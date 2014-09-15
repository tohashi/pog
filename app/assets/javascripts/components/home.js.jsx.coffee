###* @jsx React.DOM ###
POG.Home = React.createClass
  displayName: 'Home'

  getInitialState: ->
    data: []

  componentDidMount: ->

  render: ->
    `<div>
      <div className="text-center">
        <h1 className="pog-logo aldrich">pog</h1>
        <p>プレイ中・積み中のゲームを記録・共有できるWebサービス</p>
        <p>
          <a href="/piles" className="btn btn-primary btn-lg">記録する</a>
        </p>
      </div>

      <POG.Piles url="/api/pile" />

      <h5>24h</h5>
      <POG.Ranking url="/api/ranking/day" />

      <h5>all</h5>
      <POG.Ranking url="/api/ranking" />
    </div>`
