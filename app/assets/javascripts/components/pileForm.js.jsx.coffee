###* @jsx React.DOM ###

ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

POG.PileForm = React.createClass
  displayName: 'PileForm'

  getInitialState: ->
    content_name: ''
    platform_names: ''
    memo: ''
    status: 0

  handleClick: ->
    if @props.action is 'add'
      pile = @props.collection.pile.add @state
      pile.save {}, success: => @close()
    else
      pile = @props.collection.pile.findById(@props.pile.id)
      pile?.set(_.pick @state, 'content_name', 'platform_names', 'memo', 'status')
      pile?.save {id: pile.id}, success: => @close()

  handleChange: (e) ->
    data = {}
    data[e.target.name] = e.target.value
    @setState data

  componentWillReceiveProps: (nextProps) ->
    return if @props.pile and nextProps.pile.id isnt nextProps.edittingId

    pile = @props.collection.pile.findById(@props.pile?.id)
    content = @props.collection.content.findById(@props.pile?.content.id)

    @setState
      content_name: content?.get('name') or ''
      platform_names: _.pluck((pile?.get('platforms') or []), 'name').toString()
      memo: pile?.get('memo') or ''
      status: pile?.get('status') or 0

  componentDidEnter: ->
    debugger

  componentDidLeave: ->
    debugger

  close: ->
    setTimeout =>
      @props.onClose()
    , 0

  render: ->
    formNode = do (=>
      if (@props.pile and @props.pile.id isnt @props.edittingId) or
         not @props.pile and @props.action isnt 'add'
        return ``

      `<div>
        <form role="form" accept-charset="UTF-8">
          <div className="form-group">
            <label>Name</label>
            <input className="form-control" name="content_name" type="text" placeholder="Destiny" value={this.state.content_name} onChange={this.handleChange} />
          </div>
          <div className="form-group">
            <label>Platform(カンマ区切りで複数指定)</label>
            <input className="form-control" name="platform_names" type="text" placeholder="PS4, 3DS, Steam, iOS..." value={this.state.platform_names} onChange={this.handleChange} />
          </div>

          <div className="form-group">
            <label>Memo</label>
            <textarea className="form-control" name="memo" rows="2" cols="40" value={this.state.memo} onChange={this.handleChange}></textarea>
          </div>

          <div className="form-group">
            <label>Status</label><br />
            <select className="form-control" name="status" value={this.state.status} onChange={this.handleChange}>
              <option value="0">積んだ</option>
              <option value="1">プレイ中</option>
              <option value="2">Done</option>
            </select>
          </div>
        </form>
        <div className="text-right">
          <button type="button" className="btn btn-default" onClick={this.close}>Close</button>
          <button type="button" className="btn btn-primary" onClick={this.handleClick}>{this.props.action}</button>
        </div>
      </div>`
    ).bind @

    `<ReactCSSTransitionGroup transitionName="fade" component={React.DOM.div}>
      {formNode}
    </ReactCSSTransitionGroup>`
