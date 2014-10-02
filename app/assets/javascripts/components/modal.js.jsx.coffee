###* @jsx React.DOM ###

POG.Modal = React.createClass
  displayName: 'Modal'

  getInitialState: ->
    title: ''

  componentWillReceiveProps: (nextProps) ->
    contentId = nextProps.contentId
    return if contentId is @props.contentId

    content = nextProps.collection.content.findById(contentId)
    @setState title: content?.get('name')

    nextProps.model.nearlyContent.set id: contentId
    nextProps.model.nearlyContent.fetch =>

  render: ->
    nearlyContentsNodes = do =>
      @props.model.nearlyContent.get('contents').map (content) =>
        `<li className="list-group-item">
          {content.name}
        </li>`

    `<div className="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div className="modal-dialog">
        <div className="modal-content">
          <div className="modal-header">
            <button type="button" className="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span className="sr-only">Close</span></button>
            <h4 className="modal-title">{this.state.title}</h4>
          </div>
          <div className="modal-body">
            <p>このゲームを積んだ人はこんなゲームも積んでいます</p>
            <ul className="list-group">
              {nearlyContentsNodes}
            </ul>
          </div>
          <div className="modal-footer">
            <button type="button" className="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>`
