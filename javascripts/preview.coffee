class AceVimtura.Preview
  constructor: ()->
    @dom = document.createElement('div')
    @dom.classList.add('preview')
    @dom.style.width = '48%'
    @dom.style.height = '100%'
    @dom.style.background = '#ddd'
    @dom.style.display = 'inline-block'
    @dom.style['overflow-x'] = 'hidden'
    @dom.style['overflow-y'] = 'scroll'
    @timeout = null
    @isEnabled = false
    AceVimtura.dom.appendChild(@dom)
    this.enable()

  update: =>
      window.clearTimeout(@timeout) if @timeout
      @timeout = window.setTimeout(=>
        this.html(
          AceVimtura.renderer.render(
            AceVimtura.ace.getValue()
          )
        )
        @timeout = null
      , AceVimtura.options.refreshTimeout)

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
    this.update()
    AceVimtura.ace.on 'change', this.update
    this.dom.style.display = 'inline-block'

  disable: =>
    @isEnabled = false
    reg = AceVimtura.ace._eventRegistry
    return unless reg['change']
    i = reg['change'].indexOf(this.update)
    return if i < 0
    reg['change'].splice(i,1)
    this.dom.style.display = 'none'

  toggle: =>
    if @isEnabled
      this.disable()
    else
      this.enable()

