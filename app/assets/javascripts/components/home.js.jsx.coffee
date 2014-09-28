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

    collection:
      pile: new POG.Collection.Pile @, 'piles'
      content: new POG.Collection.Content @, 'contents'

  componentDidMount: ->
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
    `<div>
      <div className="text-center top-area">
        <h1 className="pog-logo aldrich">pog</h1>
        <p>積みゲーを記録・共有できるWebサービス</p>
        <p>
          <a href="#" className="btn btn-primary btn-lg" onClick={this.handleClickAdd}>Add New</a>
        </p>
      </div>

      <POG.Piles
        data={this.state.piles}
        collection={this.state.collection}
      />

    </div>`
