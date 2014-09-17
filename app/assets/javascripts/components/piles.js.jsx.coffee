###* @jsx React.DOM ###

POG.Piles = React.createClass
  displayName: 'Piles'

  componentDidMount: ->
    @props.fetch()

  handleClick: (e) ->
    e.preventDefault()
    pileId = $(e.currentTarget).data('pileId')
    @props.handleClick(pileId)

  render: ->
    pileNodes = @props.data.map ((pile) ->
      platformNodes = pile.platforms.map (platform) ->
        `<div className="badge platform-badge">{platform.name}</div>`
      listClassName = do ->
        'pile-list list-group-item clearfix ' +
        switch pile.status
          when 0 then 'bg-piling'
          when 1 then 'bg-playing'
          when 2 then 'bg-done'

      `<li className={listClassName} onClick={this.handleClick} data-pile-id={pile.id}>
        <div className="pull-left">
          <div className="list-group-item-heading">
            {platformNodes}
            <span className="pile-title">{pile.content.name}</span>
          </div>
          <p className="pile-memo list-group-item-text">{pile.memo}</p>
        </div>

        <div className="pull-right">
          <p className="list-group-item-text">{pile.last_updated} ago</p>
        </div>
      </li>`
    ).bind @

    `<div>
      <ul className="list-group">
        {pileNodes}
      </ul>
    </div>`
