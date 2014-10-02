###* @jsx React.DOM ###
window.POG =
  Model: {}
  Collection: {}
  View: {}

$ ->
  React.initializeTouchEvents(true)
  React.renderComponent \
    `<POG.Home />`,
    $('.js-main-container').get(0)
