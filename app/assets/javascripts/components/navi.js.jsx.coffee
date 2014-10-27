###* @jsx React.DOM ###

POG.Navi = React.createClass

  render: ->
    btnDataList = [
      {className: 'piling', text: '積んだ'}
      {className: 'playing', text: 'プレイ中'}
      {className: 'done', text: 'Done'}
    ]

    btns = do (->
      for data, idx in btnDataList
        className = "btn btn-#{data.className}"
        `<li>
          <button
            type="button"
            className={className}
            onClick={this.props.handleClickBtn}
            data-pile-status={idx}
          >{data.text}</button>
        </li>`
    ).bind @

    `<div className="pile-form-area">
      <ul className="list-inline pull-left">
        {btns}
      </ul>

      <div className="btn-group pull-right">
        <button type="button" className="btn btn-default dropdown-toggle" data-toggle="dropdown">
          Newest <span className="caret"></span>
        </button>
        <ul className="dropdown-menu" role="menu">
          <li><a href="#">Newest</a></li>
          <li><a href="#">Oldest</a></li>
        </ul>
      </div>
    </div>`
