AceVimtura.Utils = {}

AceVimtura.Utils.getjs = (name, done)->
  script = document.createElement('script')
  script.src = name
  script.type = 'application/javascript'
  script.async = true
  script.onload = done
  document.head.appendChild(script)

AceVimtura.Utils.getcss = (name, done)->
  link = document.createElement('link')
  link.href = name
  link.type = 'text/css'
  link.async = true
  link.rel = 'stylesheet'
  link.onload = done
  document.head.appendChild(link)
