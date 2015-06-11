define(function() {
  return AceVimtura.Utils.getcss = function(name, done) {
    var link;
    link = document.createElement('link');
    link.href = name;
    link.type = 'text/css';
    link.async = true;
    link.rel = 'stylesheet';
    link.onload = done;
    return document.head.appendChild(link);
  };
});
