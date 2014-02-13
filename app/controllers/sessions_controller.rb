class SessionsController < ApplicationController
  def create
  end

  def destroy
    session.destroy

    redirect_to root_path flash: { alert: "You are logged out." }
  end
end