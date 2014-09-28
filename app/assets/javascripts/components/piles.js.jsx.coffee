###* @jsx React.DOM ###

POG.Piles = React.createClass
  displayName: 'Piles'

  getInitialState: ->
    pileId: null
    action: 'edit'
    displayList: [0,1,2]

  handleClick: (e) ->
    e.preventDefault()
    $target = $(e.currentTarget)
    pileId = $target.data('pileId')
    @setState
      pileId: pileId
      action: if pileId then 'edit' else 'add'

  resetPileId: ->
    @setState _.pick @getInitialState(), 'pileId', 'action'

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
    displayPiles = @props.collection.pile.filter (pile) =>
      _.contains(@state.displayList, pile.get('status')) and pile.get('platforms')
    .sort (a, b) ->
      b.id - a.id

    pileNodes = displayPiles.map(((pile) =>
      editting = pile.get('id') is @state.pileId

      platformNodes = pile.get('platforms').map (platform) ->
        `<div className="badge platform-badge">{platform.name}</div>`

      listClassName = do =>
        'pile-list list-group-item clearfix ' +
        (switch pile.get('status')
          when 0 then 'bg-piling'
          when 1 then 'bg-playing'
          when 2 then 'bg-done') +
        if editting then ' edit' else ''

      formNode = do (=>
        `<POG.PileForm
          collection={this.props.collection}
          pile={pile.toJSON()}
          action={this.state.action}
          edittingId={this.state.pileId}
          onClose={this.resetPileId}
        />`
      ).bind @

      pileNode = do (=>
        unless editting
          `<div>
            <div className="pull-left">
              <div className="list-group-item-heading">
                {platformNodes}
                <span className="pile-title">{pile.get('content').name}</span>
              </div>
              <p className="pile-memo list-group-item-text">{pile.get('memo')}</p>
            </div>

            <div className="pull-right">
              <p className="pile-date list-group-item-text">{pile.get('last_updated')} ago</p>
            </div>
          </div>`
      ).bind @

      `<li className={listClassName} onClick={this.handleClick} data-pile-id={pile.get('id')}>
        {pileNode}
        {formNode}
      </li>`
    ).bind @)

    newPileNode = do (=>
      `<li className="pile-list list-group-item clearfix" onClick={this.handleClick}>
        <POG.PileForm
          collection={this.props.collection}
          action={this.state.action}
          onClose={this.resetPileId}
        />
      </li>`
    ).bind @

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
        {newPileNode}
        {pileNodes}
      </ul>
    </div>`
