requirejs.config(
  baseUrl: 'ace_vimtura'
  paths:
    ace_vimtura: './ace_vimtura'
  packages:[
    {
      name: 'ace'
      main: 'ace'
      location: "../lib/ace"
    }
    {
      name: 'ace/keyboard/vim'
      main: 'vim'
      location: '../lib/ace'
    }
  ]
)

require ['ace_vimtura'], (av)->
  window.AceVimtura = av if window
