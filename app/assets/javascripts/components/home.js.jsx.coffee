###* @jsx React.DOM ###
POG.Home = React.createClass
  displayName: 'Home'

  getInitialState: ->
    action: 'Add'
    pileId: null
    piles: []
    content: {}
    nearlyRankings: []
    _piles: new POG.Collection.Pile onSet: (data) => @setState piles: data

  handleClickAdd: (e) ->
    e.preventDefault()
    @setState
      action: 'Add'
      pileId: null
    @modal()
    $('input[name="content_name"]').val('')
    $('input[name="platform_names"]').val('')
    $('textarea[name="memo"]').val('')

  handleClickPile: (pileId, contentId) ->
    @setState
      action: 'Edit'
      pileId: pileId
    @modal()
    @fetchContent contentId, =>
      $('input[name="content_name"]').val(@state.content.name)

  handleClickModal: (data) ->
    if @state.action is 'Add'
      url = '/api/pile'
      type = 'post'
    else
      url = "/api/pile/#{@state.pileId}"
      type = 'put'

    $.ajax
      url: url
      type: type
      data: data
      dataType: 'json'
      success: (data) =>
        @state._piles.fetch => @modal 'hide'

  fetchContent: (id, done) ->
    $.ajax
      url: "/api/content/#{id}",
      dataType: 'json'
      success: (data) =>
        @setState
          content: data.content
          nearlyRankings: data.nearly_rankings
        done?()

  modal: (options = null)->
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
        model={this.state._piles}
      />

      <h5>Ranking(24h)</h5>
      <POG.Ranking url="/api/ranking/day" />

      <h5>Ranking(total)</h5>
      <POG.Ranking url="/api/ranking" />

      <div className="js-modal modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <POG.Modal
          handleClick={this.handleClickModal}
          pileId={this.state.pileId}
          action={this.state.action}
          nearlyRankings={this.state.nearlyRankings}
        />
      </div>
    </div>`
