AceVimtura = {}

AceVimtura.options =
  refreshTimeout: 500
  theme:          'twilight'
  renderer:       'markdown'
  autoFocus:      true

AceVimtura.Renderers = {}
AceVimtura.Views = {}

#=require 'getfile.coffee'
#=require 'preview.coffee'
#=require_tree 'views'

AceVimtura.init = (id, options = {})->
  this.Utils.getcss('ace_vimtura/ace_vimtura.css')
  for key in options
    this.options[key] = options.key
  @dom = document.getElementById(id)
  div = document.createElement('div')
  div.classList.add('av_editor')
  div.id = "#{id}_ace"
  @dom.appendChild(div)
  @ace = ace.edit(div.id)
  @ace.dom = div
  @ace.setKeyboardHandler('ace/keyboard/vim')
  @vimapi = ace.require('ace/keyboard/vim').CodeMirror.Vim
  this.setRenderer AceVimtura.options.renderer
  this.preview = new AceVimtura.Preview
  this.setTheme AceVimtura.options.theme
  this._defineCommands()
  this.load() || this.showHelp()
  this.ace.focus() if options.autoFocus

AceVimtura.setTheme = (name)->
  this.Utils.getjs "ace_vimtura/ace/theme-#{name}.js", =>
    @ace.setTheme("ace/theme/#{name}")

AceVimtura.setRenderer = (name)->
  this.Utils.getjs "ace_vimtura/renderers/#{name}.js", =>
    @renderer = new AceVimtura.Renderers[name.charAt(0).toUpperCase() + name.slice(1)]

AceVimtura.goSplit = ->
  @ace.dom.classList.remove('fullscreen')
  @preview.enable()
  @isSplit = true

AceVimtura.goFullscreen = ->
  @ace.dom.classList.add('fullscreen')
  @preview.disable()
  @isSplit = false


AceVimtura.toggleSplit = ->
  if @isSplit
    this.goFullscreen()
  else
    this.goSplit()

AceVimtura.save = ->
  ls = window.localStorage
  ls.ace_vimtura_file = @ace.getValue()

AceVimtura.load = ->
  ls = window.localStorage
  if data = ls.ace_vimtura_file
    @ace.setValue(data)
  else
    false

AceVimtura.showHelp = ->
    this.save()
    this.goSplit()
    this.preview.html(
      this.Views.Help
    )

AceVimtura.showMappings = ->
    this.save()
    this.goSplit()
    this.preview.html(
      this.Views.Mappings
    )

AceVimtura._defineCommands = ->
  @vimapi.defineEx 'colorscheme', 'colo', (cm, params)=>
    throw 'Specify colorscheme name' unless params.args
    name = params.args[0]
    this.setTheme(params.args[0])

  @vimapi.defineEx 'preview', 'pre', ()=>
    this.toggleSplit()

  @vimapi.defineEx 'help', 'h', (cm, params)=>
    topic = params.args && params.args[0] || ''

  @vimapi.defineEx 'write', 'w', ()=>
    this.save()

  @vimapi.defineEx 'map', 'm', ()=>
    this.showMappings()

  @vimapi.defineEx 'quit', 'q', ()=>
    this.goFullscreen()

  @vimapi.defineEx 'help', 'h', ()=>
    this.showHelp()
