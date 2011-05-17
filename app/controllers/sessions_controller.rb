class SessionsController < ApplicationController
  def new
  end

  def create
p params
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to_target_or_default movie_url, :notice => notify(:logged_in)
    else
      flash.now[:alert] = t('alert.invalid_login_or_password')
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movie_url, :notice => notify(:logged_out)
  end
end
