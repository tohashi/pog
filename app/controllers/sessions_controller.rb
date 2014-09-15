class SessionsController < ApplicationController

  def callback
    auth = request.env['omniauth.auth']
    user = User.find_by_uid(auth) || User.create_with_auth(auth)

    if user
      session[:user_id] = user.id
    else
      reset_session
    end
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
