class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id

    redirect_to pages_path, flash: { success: "You are logged in." }
  end

  def destroy
    session.destroy

    redirect_to root_path, flash: { success: "You are logged out." }
  end
end