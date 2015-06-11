var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

define(function() {
  AceVimtura.Preview = (function() {
    function Preview() {
      this.toggle = bind(this.toggle, this);
      this.disable = bind(this.disable, this);
      this.enable = bind(this.enable, this);
      this.html = bind(this.html, this);
      this.instantUpdate = bind(this.instantUpdate, this);
      this.update = bind(this.update, this);
      this.dom = document.createElement('div');
      this.dom.classList.add('av_preview');
      this.timeout = null;
      this.isEnabled = false;
      AceVimtura.dom.appendChild(this.dom);
      this.enable();
    }

    Preview.prototype.update = function() {
      if (this.timeout) {
        window.clearTimeout(this.timeout);
      }
      return this.timeout = window.setTimeout((function(_this) {
        return function() {
          _this.instantUpdate();
          return _this.timeout = null;
        };
      })(this), AceVimtura.options.refreshTimeout);
    };

    Preview.prototype.instantUpdate = function() {
      var rend;
      if (!(rend = AceVimtura.renderer)) {
        return;
      }
      return this.html(rend.render(AceVimtura.ace.getValue()));
    };

    Preview.prototype.html = function(text) {
      if (text) {
        return this.dom.innerHTML = text;
      } else {
        return this.dom.innerHTML;
      }
    };

    Preview.prototype.enable = function() {
      var reg;
      this.isEnabled = true;
      reg = AceVimtura.ace._eventRegistry;
      if (!reg['change']) {
        return;
      }
      if (reg['change'].indexOf(this.update) > -1) {
        return;
      }
      this.instantUpdate();
      AceVimtura.ace.on('change', this.update);
      return this.dom.classList.remove('collapsed');
    };

    Preview.prototype.disable = function() {
      var i, reg;
      this.isEnabled = false;
      reg = AceVimtura.ace._eventRegistry;
      if (!reg['change']) {
        return;
      }
      i = reg['change'].indexOf(this.update);
      if (i < 0) {
        return;
      }
      reg['change'].splice(i, 1);
      return this.dom.classList.add('collapsed');
    };

    Preview.prototype.toggle = function() {
      if (this.isEnabled) {
        return this.disable();
      } else {
        return this.enable();
      }
    };

    return Preview;

  })();
  return AceVimtura.Preview;
});
