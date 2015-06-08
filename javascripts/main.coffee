requirejs.config(
  baseUrl: 'ace_vimtura'
  paths:
    ace_vimtura: './ace_vimtura'
  packages:[
    {
      name: 'ace'
      main: 'ace'
      location: ""
    }
  ]
)

require ['ace_vimtura'], (av)->
  window.AceVimtura = av if window
