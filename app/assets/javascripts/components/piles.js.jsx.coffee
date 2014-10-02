###* @jsx React.DOM ###

ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

POG.Piles = React.createClass
  displayName: 'Piles'

  getInitialState: ->
    pileId: null
    contentId: null
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

  openModal: (e) ->
    e.preventDefault()
    $target = $(e.currentTarget)
    contentId = $target.data('contentId')
    @setState contentId: contentId
    $('.modal').modal()

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
        if editting then ' form' else ''

      btnClassName = do =>
        (switch pile.get('status')
          when 0 then 'btn btn-piling'
          when 1 then 'btn btn-playing'
          when 2 then 'btn btn-done')

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
            <div className="pile-text-content pull-left" onClick={this.openModal} onTouchEnd={this.openModal} data-content-id={pile.get('content').id}>
              <div className="pile-heading list-group-item-heading">
                {platformNodes}
                <span className="pile-title">{pile.get('content').name}</span>
              </div>
              <p className="pile-memo list-group-item-text">{pile.get('memo')}</p>
            </div>

            <div className="pull-right">
              <p className="pile-date list-group-item-text">{pile.get('last_updated')} ago</p>

              <div className="pile-icon-area">
                <button type="button" className={btnClassName} onClick={this.handleClick} onTouchEnd={this.handleClick} data-pile-id={pile.get('id')}>
                  <span className="glyphicon glyphicon-edit"></span>
                </button>
              </div>
            </div>
          </div>`
      ).bind @

      `<li className={listClassName}>
        {pileNode}
        {formNode}
      </li>`
    ).bind @)

    newPileNode = do (=>
      pileClassName = 'pile-list list-group-item new clearfix'
      titleNode = ''

      if !@state.pileId and @state.action is 'add'
        pileClassName += ' form'
      else
        titleNode = do (=>
          `<div className="text-center" onClick={this.handleClick} onTouchEnd={this.handleClick}>
            <span className="glyphicon glyphicon-plus"></span>
            <span>Add New</span>
          </div>`
        ).bind @

      `<li className={pileClassName}>
        {titleNode}
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

        <div className="btn-group pull-right">
          <button type="button" className="btn btn-default dropdown-toggle" data-toggle="dropdown">
            Newest <span className="caret"></span>
          </button>
          <ul className="dropdown-menu" role="menu">
            <li><a href="#">Newest</a></li>
          </ul>
        </div>
      </div>

      <ul className="list-group">
        <ReactCSSTransitionGroup transitionName="fade" component={React.DOM.div}>
          {newPileNode}
          {pileNodes}
        </ReactCSSTransitionGroup>
      </ul>

      <POG.Modal
        contentId={this.state.contentId}
        model={this.props.model}
        collection={this.props.collection}
      />
    </div>`
