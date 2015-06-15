define([
  'ace'
  'ace/keyboard/vim'
  'style'
], ->
  AceVimtura = {}

  AceVimtura.options =
    refreshTimeout: 500
    theme:          'twilight'
    renderer:       'markdown'
    autoFocus:      true

  AceVimtura.Renderers = {}
  AceVimtura.Renderers.Vendor = {}
  AceVimtura.Views = {
    Help: '<h2>Ace Vimtura</h2><h3>Index</h3><h3>Mappings</h3><p>Type in <code>:map</code> to see mappings.<h3>Commands</h3><p><code>:help</code> show this text </p><p><code>:pre</code> toggle preview mode</p><p><code>:map</code> see key mappings</p><p><code>:w</code> or <code>:write</code> save current text to your browser</p><p><code>:q</code> or <code>:quit</code> close preview and also disable rendering</p><p><code>:set</code> or <code>:se</code> sets variable if value given, shows current value otherwise<h3>Variables</h3><p>theme</p><p>renderer<small>renderer only</small></p><p>filetype <small>changes both renderer and syntax hightlighter</small></p>'
    Mappings: '<h2>Supported key bindings</h2><h3>Motion:</h3><p>h, j, k, l</p><p> gj, gk </p><p> e, E, w, W, b, B, ge, gE </p><p>f&lt;character&gt;, F&lt;character&gt;, t&lt;character&gt;, T&lt;character&gt; </p><p> $, ^, 0, -, +, _ </p><p> gg, G </p><p> % </p><p> \'&lt;character&gt;, `&lt;character&gt; </p><h3>Operator:</h3><p> d, y, c </p><p> dd, yy, cc </p><p> g~, g~g~ </p><p> &gt;, &lt;, &gt;&gt;, &lt;&lt; </p><h3> Operator-Motion: </h3><p> x, X, D, Y, C, ~ </p><h3> Action: </h3><p> a, i, s, A, I, S, o, O </p><p> zz, z., z&lt;CR&gt;, zt, zb, z- </p><p> J </p><p> u, Ctrl-r </p><p> m&lt;character&gt; </p><p> r&lt;character&gt; </p><h3> Modes: </h3><p> ESC - leave insert mode, visual mode, and clear input state.  </p><p> Ctrl-[, Ctrl-c - same as ESC.</p>'
  }
  AceVimtura.Utils = {}

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
    this._initPreview()
    this.setTheme AceVimtura.options.theme
    this._defineCommands()
    this.load() || this.showHelp()
    this.ace.focus() if options.autoFocus

  AceVimtura._initPreview = ->
    require ['preview'], (pre)=>
      @preview = new pre

  AceVimtura.setTheme = (name)->
    require ["lib/ace/theme/#{name}"], =>
      @ace.setTheme("ace/theme/#{name}")
      @themeName = name

  AceVimtura.getTheme = ->
    @themeName

  AceVimtura.setRenderer = (name)->
    require ["renderers/#{name}", 'preview'], (ren)=>
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
    require ['preview'], ()=>
      @ace.dom.classList.remove('fullscreen')
      @preview.enable()
      @isSplit = true

  AceVimtura.goFullscreen = ->
    require ['preview'], ()=>
      @ace.dom.classList.add('fullscreen')
      @preview.disable()
      @isSplit = false

  AceVimtura.toggleSplit = ->
    if @isSplit
      this.goFullscreen()
    else
      this.goSplit()

  AceVimtura.save = (filename = null)->
    ls = window.localStorage
    filename ||= @filename || 'noname'
    ls.ace_vimtura_value = @ace.getValue()
    ls.ace_vimtura_filetype = this.getFiletype()

  AceVimtura.load = (filename = null)->
    ls = window.localStorage
    return false unless ls && (val = ls.ace_vimtura_value)
    @ace.setValue(val)
    this.setFiletype(ls.ace_vimtura_filetype)
    true


  AceVimtura.showHelp = ->
    require ['preview'], ()=>
      this.goSplit()
      this.preview.html(
        this.Views.Help
      )

  AceVimtura.showMappings = ->
    require ['preview'], ()=>
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
