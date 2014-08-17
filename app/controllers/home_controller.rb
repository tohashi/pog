class HomeController < ApplicationController

  def index
    @rankings = Content.get_content_rankings(Pile.pluck('content_id'))
  end
end
