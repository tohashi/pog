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
    rankingNodes = this.state.data.map (ranking) ->
      content = ranking.content
      url = "/contents/#{content.id}"
      `<a href={url}>
        <li className="list-group-item">
          <span className="badge">{ranking.count}</span>
          {content.name}
        </li>
      </a>`

    `<ul className="list-group">
      {rankingNodes}
    </ul>`
