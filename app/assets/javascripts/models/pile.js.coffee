class POG.Collection.Pile extends Backbone.Collection
  url: '/api/pile'

  initialize: (options) ->
    @onSet = options.onSet
    @onSet([])

  fetch: (done) ->
    super success: =>
      @onSet(@toJSON())
      done?()
