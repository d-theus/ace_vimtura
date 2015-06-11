define(['lib/renderers/haml'], function(haml) {
  return AceVimtura.Renderers.Haml = (function() {
    function Haml(options) {
      if (options == null) {
        options = {};
      }
      return AceVimtura.Renderers.Vendor.Haml;
    }

    return Haml;

  })();
});
