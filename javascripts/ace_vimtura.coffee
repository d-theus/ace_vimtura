AceVimtura = {}

#=require 'getfile.coffee'
#=require 'preview.coffee'

AceVimtura.init = (id)->
  @dom = document.getElementById(id)
  @ace = ace.edit(id)

AceVimtura.setTheme = (name)->
  this.Utils.getfile "ace_vimtura/ace/theme-#{name}.js", =>
    @ace.setTheme("ace/theme/#{name}")