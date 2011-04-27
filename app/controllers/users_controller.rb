class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.order('username asc')
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, :notice => t('notice.thank_you_for_signing_up')
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_path, :notice => updated(:profile)
    else
      render :action => 'edit'
    end
  end

  def destroy
    redirect_to users_path
  end
  
  def edit_roles
  end

  def update_roles
    @user.roles = params[:user][:roles] unless params[:user].nil?
    if @user.save
      redirect_to users_path, :notice => updated_p(@user.username, :role)
    else
      render :action => 'edit_roles'
    end
  end
end

