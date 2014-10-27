###* @jsx React.DOM ###

POG.PileContent = React.createClass
  displayName: 'PileContent'

  render: ->
    pile = @props.pile

    platformNodes = pile.get('platforms').map (platform) ->
      `<div className="badge platform-badge">{platform.name}</div>`

    btnClassName = do =>
      (switch pile.get('status')
        when 0 then 'btn btn-piling'
        when 1 then 'btn btn-playing'
        when 2 then 'btn btn-done')

    `<div>
      <div className="pile-text-content pull-left" onClick={this.props.handleClickOpen} data-content-id={pile.get('content').id}>
        <div className="pile-heading list-group-item-heading">
          {platformNodes}
          <span className="pile-title">{pile.get('content').name}</span>
        </div>
        <p className="pile-memo list-group-item-text">{pile.get('memo')}</p>
      </div>

      <div className="pull-right">
        <p className="pile-date list-group-item-text l-abs">{pile.get('last_updated')} ago</p>

        <div className="pile-icon-area l-abs">
          <button type="button" className={btnClassName} onClick={this.props.handleClickEdit} data-pile-id={pile.get('id')}>
            <span className="glyphicon glyphicon-edit"></span>
          </button>
          <button type="button" className={btnClassName} onClick={this.props.handleClickRemove} data-pile-id={pile.get('id')}>
            <span className="glyphicon glyphicon-remove"></span>
          </button>
        </div>
      </div>
    </div>`
