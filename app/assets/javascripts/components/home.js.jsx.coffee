###* @jsx React.DOM ###
POG.Home = React.createClass
  displayName: 'Home'

  getInitialState: ->
    action: 'Add'
    data: []
    piles: []

  handleClickAdd: (e) ->
    e.preventDefault()
    @setState action: 'Add'
    @modal()

  handleClickPile: (data) ->
    @setState action: 'Edit'
    @modal()

  handleClickModal: (data) ->
    url = '/api/pile'

    $.ajax
      url: url
      type: 'post'
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

  modal: (options = null)->
    $('.js-modal').modal(options)

  render: ->
    `<div>
      <div className="text-center">
        <h1 className="pog-logo aldrich">pog</h1>
        <p>積みゲーを記録・共有できるWebサービス</p>
        <p>
          <a href="#" className="btn btn-primary btn-lg" onClick={this.handleClickAdd}>Add New</a>
        </p>
      </div>

      <POG.Piles
        data={this.state.piles}
        fetch={this.fetchPiles}
        handleClick={this.handleClickPile}
      />

      <h5>Ranking(24h)</h5>
      <POG.Ranking url="/api/ranking/day" />

      <h5>Ranking(total)</h5>
      <POG.Ranking url="/api/ranking" />

      <div className="js-modal modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <POG.Modal
          action={this.state.action}
          handleClick={this.handleClickModal}
        />
      </div>
    </div>`
