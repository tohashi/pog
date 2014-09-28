class POG.Collection.Base extends Backbone.Collection
  initialize: (@parent) ->
    @listenTo @, 'sync', => @parent.forceUpdate()

  findById: (id) ->
    this.findWhere(id: id)

  fetch: (done) ->
    super success: => done?()
