###* @jsx React.DOM ###
POG.Ranking = React.createClass
  displayName: 'Ranking',

  getInitialState: ->
    data: []

  load: ->
    $.ajax
      url: @props.url,
      dataType: 'json'
      success: ((data) ->
        @setState data: data
      ).bind @

  componentDidMount: ->
    @load()

  render: ->
    rankingNodes = @state.data.map (ranking) ->
      `<li className="list-group-item">
          <span className="badge">{ranking.count}</span>
          {ranking.content.name}
        </li>`

    `<ul className="list-group">
      {rankingNodes}
    </ul>`
