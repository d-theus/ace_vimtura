define(->
  AceVimtura.Utils.getcss = (name, done)->
    link = document.createElement('link')
    link.href = name
    link.type = 'text/css'
    link.async = true
    link.rel = 'stylesheet'
    link.onload = done
    document.head.appendChild(link)
)
