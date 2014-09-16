###* @jsx React.DOM ###

POG.Modal = React.createClass
  displayName: 'Modal'

  render: ->
    `<div className="modal-dialog">
      <div className="modal-content">
        <div className="modal-header">
          <button type="button" className="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span className="sr-only">Close</span></button>
          <h4 className="modal-title">Add New</h4>
        </div>
        <div className="modal-body">

          <form role="form" accept-charset="UTF-8">
            <div className="form-group">
              <label>Name</label>
              <input className="form-control" name="content_name" type="text" placeholder="Destiny" />
            </div>
            <div className="form-group">
              <label>Platform(カンマ区切りで複数指定)</label>
              <input className="form-control" name="platform_names" type="text" placeholder="PS4,3DS,Steam" />
            </div>

            <div className="form-group">
              <label>Memo</label>
              <textarea className="form-control" name="memo" rows="2" cols="40"></textarea>
            </div>

            <div className="form-group">
              <label>Status</label><br />
              <label className="radio-inline">
                <input type="radio" name="inlineRadioOptions" value="piling" checked="checked" /> 積み
              </label>
              <label className="radio-inline">
                <input type="radio" name="inlineRadioOptions" value="playing" /> プレイ中
              </label>
              <label className="radio-inline">
                <input type="radio" name="inlineRadioOptions" value="done" /> Done
              </label>
            </div>
          </form>

        </div>
        <div className="modal-footer">
          <button type="button" className="btn btn-default" data-dismiss="modal">Close</button>
          <button type="button" className="btn btn-primary">Add</button>
        </div>
      </div>
    </div>`
 
