define(->
  string = '.av_editor { display: inline-block; width: 48%; min-height: 500px; height: 100%; transition: width 1s; -webkit-transition: width 1s; } .av_editor.fullscreen { width: 100%; } .av_preview { display: inline-block; width: 48%; min-height: 500px; height: 100%; background: #eee; overflow-x: hidden; overflow-y: scroll; transition: width 1s; -webkit-transition: width 1s; } .av_preview.collapsed { width: 0; }'

  st = document.createElement('style')
  st.innerHTML = string
  document.head.appendChild(st)
)
