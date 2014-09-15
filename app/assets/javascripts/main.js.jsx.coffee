###* @jsx React.DOM ###
window.POG = {}

$ ->
  React.renderComponent \
    `<POG.Home />`,
    $('.js-main-container').get(0)
