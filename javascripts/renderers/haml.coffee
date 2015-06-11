define([
  '../../lib/renderers/haml'
], (haml)->
  class AceVimtura.Renderers.Haml
    constructor: (options = {})->
      return AceVimtura.Renderers.Vendor.Haml
)
