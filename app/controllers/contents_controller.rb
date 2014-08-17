class ContentsController < ApplicationController
  def show
    @content = Content.find(params[:id])

    @nearly_rankings = Content.get_nearly_content_rankings(params[:id])
  end
end
