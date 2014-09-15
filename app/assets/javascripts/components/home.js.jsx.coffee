###* @jsx React.DOM ###
POG.Home = React.createClass
  displayName: 'Home'

  getInitialState: ->
    data: []

  onClick: (e) ->
    e.preventDefault()
    $('.js-new-modal').modal()

  render: ->
    `<div>
      <div className="text-center">
        <h1 className="pog-logo aldrich">pog</h1>
        <p>積みゲーを記録・共有できるWebサービス</p>
        <p>
          <a href="#" className="btn btn-primary btn-lg" onClick={this.onClick}>Add New</a>
        </p>
      </div>

      <POG.Piles url="/api/pile" />

      <h5>Ranking(24h)</h5>
      <POG.Ranking url="/api/ranking/day" />

      <h5>Ranking(total)</h5>
      <POG.Ranking url="/api/ranking" />
    </div>`
