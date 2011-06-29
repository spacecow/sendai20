class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to_target_or_default root_url, :notice => success(:logged_in)
    else
      flash.now[:alert] = t('alert.invalid_login_or_password')
      @opinions = Opinion.order("updated_at desc")
      @opinions = @opinions.where("user_id <> ?",current_user.id) if current_user
      @opinions = @opinions.limit(1)
      @user = User.new
      render :action => 'operator/movie'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => success(:logged_out)
  end
end
