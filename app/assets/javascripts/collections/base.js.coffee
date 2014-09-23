class POG.Collection.Base extends Backbone.Collection
  initialize: (@parent, @paramName) ->
    @setState()
    @listenTo @, 'sync', =>
      @setState()

  setState: ->
    data = {}
    data[@paramName] = @toJSON()
    @parent.setState data

  findById: (id) ->
    this.findWhere(id: id)

  fetch: (done) ->
    super success: => done?()
