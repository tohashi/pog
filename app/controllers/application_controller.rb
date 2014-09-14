class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_logined

  private
    def check_logined
      if session[:user_id]
        begin
          @user = User.find(session[:user_id])
        rescue ActiveRecord::RecordNotFound
          reset_session
        end
      end

      unless @user
        # guest
        @user = guest_user
      end
    end

    def guest_user
      User.guest.first
    end

end
