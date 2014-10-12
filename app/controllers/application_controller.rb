class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user

  def current_user
    @user = ApplicationController.check_logined(session)
  end

  def self.check_logined(session)
    if session[:user_id]
      begin
        user = User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end

    # guest
    # user || User.guest.first
    user || User.first
  end
end
