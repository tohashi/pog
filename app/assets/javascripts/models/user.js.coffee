class POG.Model.User extends POG.Model.Base
  urlRoot: '/api/user'

  isGuest: ->
    @get('authority') is 'guest'
