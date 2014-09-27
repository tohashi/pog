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

  handleClickAdd: (e) ->
    e.preventDefault()
    @setState
      pileId: null
      contentId: null
      action: 'Add'

    @modal()

  handleClickPile: (pileId, contentId) ->
    @setState
      action: 'Edit'
      pileId: pileId
      contentId: contentId
    @modal()

  fetchContent: (id, done) ->
    $.ajax
      url: "/api/content/#{id}",
      dataType: 'json'
      success: (data) =>
        @setState
          nearlyRankings: data.nearly_rankings
        done?()

  handleClickModal: (data) ->
    if @state.action is 'Add'
      pile = @state.collection.pile.add(data)
      pile.save {}, success: => @modal 'hide'
    else
      pile = @state.collection.pile.findById(@state.pileId)
      pile?.set(data)
      pile?.save {id: pile.id}, success: => @modal 'hide'

  modal: (options = null) ->
    $('.js-modal').modal(options)

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
        handleClick={this.handleClickPile}
        collection={this.state.collection.pile}
      />

      <div className="js-modal modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <POG.Modal
          handleClick={this.handleClickModal}
          action={this.state.action}
          nearlyRankings={this.state.nearlyRankings}

          collection={this.state.collection}
          pileId={this.state.pileId}
          contentId={this.state.contentId}
        />
      </div>
    </div>`
