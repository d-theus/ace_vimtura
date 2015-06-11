var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

define(function() {
  return AceVimtura.Renderers.Html = (function() {
    function Html(options) {
      this.render = bind(this.render, this);
    }

    Html.prototype.render = function(text) {
      return text;
    };

    return Html;

  })();
});
