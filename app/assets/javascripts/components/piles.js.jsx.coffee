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

  remove: (e) ->
    e.preventDefault()
    $target = $(e.currentTarget)
    pileId = $target.data('pileId')
    pile = @props.collection.pile.findById(pileId)
    pile?.destroy success: => @resetPileId()

  resetPileId: ->
    @setState _.pick @getInitialState(), 'pileId', 'action'

  toggleDisplay: (e) ->
    e.preventDefault()

    $target = $(e.currentTarget)
    status = $target.data('pileStatus')
    displayList = _.clone @state.displayList
    idx = _.indexOf displayList, status

    if _.contains displayList, status
      displayList.splice(idx, 1)
      $target.addClass('btn-disable')
    else
      displayList.push(status)
      $target.removeClass('btn-disable')

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
          when 0 then 'is-piling'
          when 1 then 'is-playing'
          when 2 then 'is-done') +
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
              <p className="pile-date list-group-item-text l-abs">{pile.get('last_updated')} ago</p>

              <div className="pile-icon-area l-abs">
                <button type="button" className={btnClassName} onClick={this.handleClick} onTouchEnd={this.handleClick} data-pile-id={pile.get('id')}>
                  <span className="glyphicon glyphicon-edit"></span>
                </button>
                <button type="button" className={btnClassName} onClick={this.remove} onTouchEnd={this.remove} data-pile-id={pile.get('id')}>
                  <span className="glyphicon glyphicon-remove"></span>
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
      <POG.Navi
        handleClickBtn={this.toggleDisplay}
      />

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
