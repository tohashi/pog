###* @jsx React.DOM ###

POG.Modal = React.createClass
  displayName: 'Modal'

  getInitialState: ->
    content_name: ''
    platform_names: ''
    memo: ''
    status: 0

  handleClick: ->
    @props.handleClick @state

  handleChange: (e) ->
    data = {}
    data[e.target.name] = e.target.value
    @setState data

  componentWillReceiveProps: (nextProps) ->
    pile = nextProps.collection.pile.findById(nextProps.pileId)
    content = nextProps.collection.content.findById(nextProps.contentId)

    @setState
      content_name: content?.get('name') or ''
      platform_names: _.pluck((pile?.get('platforms') or []), 'name').toString()
      memo: pile?.get('memo') or ''
      status: pile?.get('status') or 0

  render: ->
    title = switch (@props.action)
      when 'Add' then 'Add New'
      when 'Edit' then 'Edit'

    nearlyRankingsNodes = do =>
      return unless @props.nearlyRankings.length

      rankingNodes = @props.nearlyRankings.map (ranking) =>
        `<li className="list-group-item">
          <span className="badge">{ranking.count}</span>
          {ranking.content.name}
        </li>`

      `<div>
        <h5>このゲームを積んだ人はこんなゲームも積んでいます</h5>
        <ul className="list-group">
          {rankingNodes}
        </ul>
      </div>`

    `<div className="modal-dialog">
      <div className="modal-content">
        <div className="modal-header">
          <button type="button" className="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span className="sr-only">Close</span></button>
          <h4 className="modal-title">{title}</h4>
        </div>
        <div className="modal-body">

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

          {nearlyRankingsNodes}

        </div>
        <div className="modal-footer">
          <button type="button" className="btn btn-default" data-dismiss="modal">Close</button>
          <button type="button" className="btn btn-primary" onClick={this.handleClick}>{this.props.action}</button>
        </div>
      </div>
    </div>`
 
