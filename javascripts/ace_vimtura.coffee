AceVimtura = {}

AceVimtura.options =
  refreshTimeout: 500
  theme:          'twilight'
  renderer:       'markdown'

AceVimtura.Renderers = {}
AceVimtura.Views = {}

#=require 'getfile.coffee'
#=require 'preview.coffee'
#=require 'views/mappings.coffee'

AceVimtura.init = (id)->
  @dom = document.getElementById(id)
  div = document.createElement('div')
  div.classList.add('editor')
  div.id = "#{id}_ace"
  div.style.width = '48%'
  div.style.height = '100%'
  div.style.display = 'inline-block'
  @dom.appendChild(div)
  @ace = ace.edit(div.id)
  @ace.dom = div
  @ace.setKeyboardHandler('ace/keyboard/vim')
  @vimapi = ace.require('ace/keyboard/vim').CodeMirror.Vim
  @isSplit = true
  this.setRenderer AceVimtura.options.renderer
  this.preview = new AceVimtura.Preview
  this.setTheme AceVimtura.options.theme
  this._defineCommands()
  this.load()

AceVimtura.setTheme = (name)->
  this.Utils.getjs "ace_vimtura/ace/theme-#{name}.js", =>
    @ace.setTheme("ace/theme/#{name}")

AceVimtura.setRenderer = (name)->
  this.Utils.getjs "ace_vimtura/renderers/#{name}.js", =>
    @renderer = new AceVimtura.Renderers[name.charAt(0).toUpperCase() + name.slice(1)]

AceVimtura.goSplit = ->
  @ace.dom.style.width = '48%'
  @preview.enable()
  @isSplit = true

AceVimtura.goFullscreen = ->
  @ace.dom.style.width = '100%'
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
    this.save()
    AceVimtura.goSplit()
    AceVimtura.preview.html(
      AceVimtura.Views.Mappings
    )

  @vimapi.defineEx 'quit', 'q', ()=>
    AceVimtura.goFullscreen()
