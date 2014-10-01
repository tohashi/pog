class POG.Model.Base extends Backbone.Model
  initialize: (@parent) ->
    @listenTo @, 'sync', => @parent.forceUpdate()

  fetch: (done) ->
    super success: => done?()
