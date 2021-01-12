class SessionsController < ApplicationController
  def new
    if current_user
      flash[:notice] = 'You are already logged in!'
      login_redirect(current_user)
    end
  end

  private

  def login_redirect(user)
    session[:user_id] = user.id
    redirect_to repo_path
  end
end
