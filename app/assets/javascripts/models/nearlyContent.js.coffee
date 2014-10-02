class POG.Model.NearlyContent extends POG.Model.Base
  urlRoot: '/api/content/nearly'

  # TODO collection
  defaults:
    contents: []

  parse: (res) ->
    contents: res
