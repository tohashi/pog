class HomeController < ApplicationController

  def index
  end

  def destroy
    user = User.find(params[:id])
    Pile.destroy_all(user_id: user.id)
    user.destroy
    redirect_to root_path
  end
end
