###* @jsx React.DOM ###

POG.Piles = React.createClass
  displayName: 'Piles'

  getInitialState: ->
    displayList: [0,1,2]

  handleClick: (e) ->
    e.preventDefault()
    $target = $(e.currentTarget)
    pileId = $target.data('pileId')
    contentId = $target.data('contentId')
    @props.handleClick(pileId, contentId)

  handleClickBtn: (e) ->
    e.preventDefault()

    $target = $(e.currentTarget)
    status = $target.data('pileStatus')
    displayList = _.clone @state.displayList
    idx = _.indexOf displayList, status

    if _.contains displayList, status
      displayList.splice(idx, 1)
      $target.addClass('disable')
    else
      displayList.push(status)
      $target.removeClass('disable')

    @setState displayList: displayList

  render: ->
    displayPiles = @props.data.filter (pile) =>
      _.contains @state.displayList, pile.status
    .sort (a, b) ->
      b.id - a.id

    pileNodes = displayPiles.map(((pile) =>
      platformNodes = pile.platforms.map (platform) ->
        `<div className="badge platform-badge">{platform.name}</div>`
      listClassName = do ->
        'pile-list list-group-item clearfix ' +
        switch pile.status
          when 0 then 'bg-piling'
          when 1 then 'bg-playing'
          when 2 then 'bg-done'

      `<li className={listClassName} onTouchEnd={this.handleClick} onClick={this.handleClick} data-pile-id={pile.id} data-content-id={pile.content.id}>
        <div className="pull-left">
          <div className="list-group-item-heading">
            {platformNodes}
            <span className="pile-title">{pile.content.name}</span>
          </div>
          <p className="pile-memo list-group-item-text">{pile.memo}</p>
        </div>

        <div className="pull-right">
          <p className="pile-date list-group-item-text">{pile.last_updated} ago</p>
          <div className="pile-edit-btn btn-group">
            <button type="button" className="btn btn-danger">Action</button>
            <button type="button" className="btn btn-danger dropdown-toggle" data-toggle="dropdown">
              <span className="caret"></span>
              <span className="sr-only">Toggle Dropdown</span>
            </button>
            <ul className="dropdown-menu" role="menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li className="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul>
          </div>
        </div>
      </li>`
    ).bind @)

    `<div>
      <div className="pile-form-area">
        <ul className="list-inline pull-left">
          <li><button type="button" className="btn btn-piling" onClick={this.handleClickBtn} data-pile-status="0">積んだ</button></li>
          <li><button type="button" className="btn btn-playing" onClick={this.handleClickBtn} data-pile-status="1">プレイ中</button></li>
          <li><button type="button" className="btn btn-done" onClick={this.handleClickBtn} data-pile-status="2">Done</button></li>
        </ul>

        <div className="form-group pull-right">
          <select className="form-control" name="status" value={this.state.status} onChange={this.handleChange}>
            <option value="0">Newest</option>
          </select>
        </div>
      </div>

      <ul className="list-group">
        {pileNodes}
      </ul>
    </div>`
