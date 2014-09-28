###* @jsx React.DOM ###

POG.Modal = React.createClass
  displayName: 'Modal'

  render: ->
    nearlyRankingsNodes = do =>
      return unless @props.nearlyRankings.length

      rankingNodes = @props.nearlyRankings.map (ranking) =>
        `<li className="list-group-item">
          <span className="badge">{ranking.count}</span>
          {ranking.content.name}
        </li>`

      `<div>
        <h5>このゲームを積んだ人はこんなゲームも積んでいます</h5>
        <ul className="list-group">
          {rankingNodes}
        </ul>
      </div>`
