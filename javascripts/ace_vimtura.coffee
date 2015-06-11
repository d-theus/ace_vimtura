define([
  'ace'
  'ace/keyboard/vim'
], ->
  AceVimtura = {}

  AceVimtura.options =
    refreshTimeout: 500
    theme:          'twilight'
    renderer:       'markdown'
    autoFocus:      true

  AceVimtura.Renderers = {}
  AceVimtura.Renderers.Vendor = {}
  AceVimtura.Views = {}
  AceVimtura.Utils = {}
  require ['utils/getfile'], ->
    AceVimtura.Utils.getcss('ace_vimtura/ace_vimtura.css')

  #=require 'preview.coffee'
  #=require_tree 'views'

  AceVimtura.init = (id, options = {})->
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
    this.setFiletype('markdown')
    this.preview = new AceVimtura.Preview
    this.setTheme AceVimtura.options.theme
    this._defineCommands()
    this.load() || this.showHelp()
    this.ace.focus() if options.autoFocus

  AceVimtura.setTheme = (name)->
    require ["../lib/ace/theme/#{name}"], =>
      @ace.setTheme("ace/theme/#{name}")
      @themeName = name


  AceVimtura.getTheme = ->
    @themeName

  AceVimtura.setRenderer = (name)->
    require ["renderers/#{name}"], (ren)=>
      @renderer = new ren
      @preview.instantUpdate()
      @rendererName = name

  AceVimtura.getRenderer = ->
    @rendererName

  AceVimtura.setMode = (name)->
    @ace.getSession().setMode("ace/mode/#{name}")
    @modeName = name

  AceVimtura.getMode = ->
    @modeName

  AceVimtura.setFiletype = (name)->
    this.setRenderer(name)
    this.setMode(name)
    @filetypeName = name

  AceVimtura.getFiletype = ->
    @filetypeName

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

  AceVimtura.setVariable = (variable, value)->
    methBase = variable.charAt(0).toUpperCase()+variable.slice(1)
    if value
      if this['set' + methBase]
        this['set' + methBase](value)
      else
        throw "No such variable: #{variable}"
    else
      if this['get' + methBase]
        throw this['get' + methBase]()
      else
        throw "No such variable: #{variable}"

  AceVimtura._defineCommands = ->
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

    @vimapi.defineEx 'set', 'se', (cm, params)=>
      throw 'Specify variable name' unless params.args && params.args[0]
      this.setVariable(
        params.args[0]
        params.args[1]
      )

  return AceVimtura
)
