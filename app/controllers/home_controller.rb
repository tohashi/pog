class HomeController < ApplicationController
  def index
  end

  def destroy
    User.destroy(@user.id)
    reset_session
    redirect_to root_path
  end
end
