###* @jsx React.DOM ###

POG.Piles = React.createClass
  displayName: 'Piles'

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
    pileNodes = @state.data.map (pile) ->
      platformNodes = pile.platforms.map (platform) ->
        `<div className="inline">[{platform.name}]</div>`

      `<li className="list-group-item">
        <h4 className="list-group-item-heading">
          {platformNodes}
          {pile.content.name}
        </h4>
        <p className="list-group-item-text">edit</p>
        <p className="list-group-item-text">delete</p>
      </li>`

    `<div>
      <ul className="list-group">
        {pileNodes}
      </ul>
    </div>`
