class AceVimtura.Preview
  constructor: ()->
    @dom = document.createElement('div')
    @dom.classList.add('av_preview')
    @timeout = null
    @isEnabled = false
    AceVimtura.dom.appendChild(@dom)
    this.enable()

  update: =>
      window.clearTimeout(@timeout) if @timeout
      @timeout = window.setTimeout(=>
        this.instantUpdate()
        @timeout = null
      , AceVimtura.options.refreshTimeout)

  instantUpdate: =>
    return unless rend = AceVimtura.renderer
    this.html(
      rend.render(
        AceVimtura.ace.getValue()
      )
    )

  html: (text)=>
    if text
      @dom.innerHTML = text
    else
      @dom.innerHTML

  enable: =>
    @isEnabled = true
    reg = AceVimtura.ace._eventRegistry
    return unless reg['change']
    return if reg['change'].indexOf(this.update) > -1
    this.instantUpdate()
    AceVimtura.ace.on 'change', this.update
    @dom.classList.remove('collapsed')

  disable: =>
    @isEnabled = false
    reg = AceVimtura.ace._eventRegistry
    return unless reg['change']
    i = reg['change'].indexOf(this.update)
    return if i < 0
    reg['change'].splice(i,1)
    @dom.classList.add('collapsed')

  toggle: =>
    if @isEnabled
      this.disable()
    else
      this.enable()

