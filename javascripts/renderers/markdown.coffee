class AceVimtura.Renderers.Markdown
  constructor: (options = {})->
    @marked = AceVimtura.Renderers.Vendor.marked
    options.gfm ||= true
    options.tables ||= true
    options.breaks ||= false
    options.pedantic ||= true
    options.sanitize ||= true
    options.smartLists ||= true
    options.smartypants ||= true
    @marked.setOptions(options)

  render: (text)=>
    @marked(text)
