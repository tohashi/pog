###* @jsx React.DOM ###
POG.Home = React.createClass
  displayName: 'Home'

  getInitialState: ->
    piles: []
    contents: []
    nearlyRankings: []

    # app state
    action: 'Add'
    pileId: null
    contentId: null

    model:
      user: new POG.Model.User @
    collection:
      pile: new POG.Collection.Pile @
      content: new POG.Collection.Content @

  componentDidMount: ->
    @state.model.user.fetch()
    @state.collection.pile.fetch()
    @state.collection.content.fetch()

  fetchContent: (id, done) ->
    $.ajax
      url: "/api/content/#{id}",
      dataType: 'json'
      success: (data) =>
        @setState
          nearlyRankings: data.nearly_rankings
        done?()

  render: ->

    mainContentNode = do (=>
      if @state.model.user.isGuest()
        `<div className="text-center">
          <a href="/auth/twitter">
            <button type="button" className="btn btn-primary btn-lg">
              Sign in with Twitter
            </button>
          </a>
        </div>`
      else
        `<POG.Piles
          data={this.state.piles}
          collection={this.state.collection}
        />`
    ).bind @

    `<div>
      <div className="text-center top-area">
        <h1 className="pog-logo aldrich">pog</h1>
        <p></p>
      </div>
      {mainContentNode}
    </div>`
