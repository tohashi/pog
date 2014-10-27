###* @jsx React.DOM ###

POG.Navi = React.createClass
  displayName: 'Navi'

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

    dropdowns = do (->
      for type in ['Newest', 'Oldest']
        `<li>
          <a
            href="#"
            onClick={this.props.handleClickSort}
            data-sort-type={type}
          >{type}</a>
        </li>`
    ).bind @

    `<div className="pile-form-area">
      <ul className="list-inline pull-left">
        {btns}
      </ul>

      <div className="btn-group pull-right">
        <button type="button" className="btn btn-default dropdown-toggle" data-toggle="dropdown">
          {this.props.sortType} <span className="caret"></span>
        </button>
        <ul className="dropdown-menu" role="menu">
          {dropdowns}
        </ul>
      </div>
    </div>`
