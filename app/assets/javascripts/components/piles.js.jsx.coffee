###* @jsx React.DOM ###

ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

POG.Piles = React.createClass
  displayName: 'Piles'

  getInitialState: ->
    pileId: null
    contentId: null
    action: 'edit'
    displayList: [0,1,2]
    sortType: 'Newest'

  edit: (e) ->
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

  changeSortType: (e) ->
    e.preventDefault()
    $target = $(e.currentTarget)
    @setState 'sortType': $target.data('sortType')

  getDisplayPiles: ->
    comparator = switch @state.sortType
      when 'Newest'
        (a, b) -> b.id - a.id
      when 'Oldest'
        (a, b) -> a.id - b.id
    @props.collection.pile.filter (pile) =>
      _.contains(@state.displayList, pile.get('status')) and pile.get('platforms')
    .sort comparator

  openModal: (e) ->
    e.preventDefault()
    $target = $(e.currentTarget)
    contentId = $target.data('contentId')
    @setState contentId: contentId
    $('.modal').modal()

  render: ->
    pileNodes = @getDisplayPiles().map(((pile) =>
      editting = pile.get('id') is @state.pileId

      listClassName = do =>
        'pile-list list-group-item clearfix ' +
        (switch pile.get('status')
          when 0 then 'is-piling'
          when 1 then 'is-playing'
          when 2 then 'is-done') +
        if editting then ' form' else ''

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
          `<POG.PileContent
            pile={pile}
            handleClickEdit={this.edit}
            handleClickRemove={this.remove}
            handleClickOpen={this.openModal}
          />`
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
          `<div className="text-center" onClick={this.edit} onTouchEnd={this.edit}>
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
        sortType={this.state.sortType}
        handleClickSort={this.changeSortType}
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
