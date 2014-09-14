class HomeController < ApplicationController

  def index
    @ranking_all = Content.get_content_rankings(Pile.get_content_ids)

    @ranking_60min = Content.get_content_rankings(Pile.get_content_ids(3600))
  end

  def destroy
    user = User.find(params[:id])
    Pile.destroy_all(user_id: user.id)
    user.destroy
    redirect_to root_path
  end
end
