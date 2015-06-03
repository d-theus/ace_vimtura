var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

AceVimtura.Renderers.Haml = (function() {
  function Haml(options) {
    if (options == null) {
      options = {};
    }
    this.render = bind(this.render, this);
  }

  Haml.prototype.render = function(text) {
    return text;
  };

  return Haml;

})();
