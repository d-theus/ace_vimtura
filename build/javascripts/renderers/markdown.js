var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

define(['lib/renderers/markdown'], function(marked) {
  return AceVimtura.Renderers.Markdown = (function() {
    function Markdown(options) {
      if (options == null) {
        options = {};
      }
      this.render = bind(this.render, this);
      this.marked = marked;
      options.gfm || (options.gfm = true);
      options.tables || (options.tables = true);
      options.breaks || (options.breaks = false);
      options.pedantic || (options.pedantic = true);
      options.sanitize || (options.sanitize = true);
      options.smartLists || (options.smartLists = true);
      options.smartypants || (options.smartypants = true);
      this.marked.setOptions(options);
    }

    Markdown.prototype.render = function(text) {
      return this.marked(text);
    };

    return Markdown;

  })();
});
