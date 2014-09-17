###* @jsx React.DOM ###
POG.Home = React.createClass
  displayName: 'Home'

  getInitialState: ->
    action: 'Add'
    pileId: null
    piles: []
    contentName: ''
    platformNames: ''
    memo: ''
    status: 0

  handleClickAdd: (e) ->
    e.preventDefault()
    @setState
      action: 'Add'
      pileId: null
      contentName: ''
      platformNames: ''
      memo: ''
      status: 0
    @modal()
    $('input[name="content_name"]').val(@state.contentName)

  handleClickPile: (pileId) ->
    @setState
      action: 'Edit'
      pileId: pileId
      contentName: 'test'
      platformNames: 'test'
      memo: ''
      status: 0
    @modal()
    $('input[name="content_name"]').val(@state.contentName)

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
        @fetchPiles => @modal 'hide'

  fetchPiles: (done) ->
    $.ajax
      url: '/api/pile',
      dataType: 'json'
      success: (data) =>
        @setState piles: data
        done?()

  fetchContent: (id, done) ->
    $.ajax
      url: "/api/content/#{id}",
      dataType: 'json'
      success: (data) =>
        @setState content: data
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
        fetch={this.fetchPiles}
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
          contentName={this.state.contentName}
          platformNames={this.state.platformNames}
          memo={this.state.memo}
          status={this.state.status}
        />
      </div>
    </div>`
