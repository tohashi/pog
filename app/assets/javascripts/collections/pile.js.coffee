class POG.Model.Pile extends Backbone.Model
  url: '/api/pile'

class POG.Collection.Pile extends POG.Collection.Base
  model: POG.Model.Pile
  url: '/api/pile'
