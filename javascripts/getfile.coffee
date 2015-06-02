AceVimtura.Utils = {}

AceVimtura.Utils.getjs = (name, done)->
  script = document.createElement('script')
  script.src = name
  script.type = 'application/javascript'
  script.async = true
  script.onload = done

  document.head.appendChild(script)
