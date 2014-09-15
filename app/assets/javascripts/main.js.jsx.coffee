###* @jsx React.DOM ###

do ->

  RankingList = React.createClass
    displayName: 'RankingList',

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
        `<a href="/contents/{content.id}">
          <li className="list-group-item">
            <span className="badge">{ranking.count}</span>
            {content.name}
          </li>
        </a>`

      `<ul className="list-group">
        {rankingNodes}
      </ul>`

  React.renderComponent \
    `<RankingList url="/api/ranking/day" />`,
    $('.js-ranking-day').get(0)

  React.renderComponent \
    `<RankingList url="/api/ranking/all" />`,
    $('.js-ranking-all').get(0)
