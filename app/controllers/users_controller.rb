class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.order('email asc')
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.valid?
      if params[:address_checked] == "true"
        @user.save
        session[:user_id] = @user.id
        redirect_to root_path, :notice => join(notify(:thank_you_for_signing_up),notify(:logged_in))
      else
        @map_url = map_url
        params[:address_checked] = true
        load_opinions
        render :template => 'operator/movie'
      end
    else
      @map_url = map_url
      params[:address_checked] = true
      load_opinions
      render :template => 'operator/movie'
    end
  end

  def edit
    @user = current_user
  end

  def update
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
      redirect_to users_path, :notice => updated_p(@user.email, :role)
    else
      render :action => 'edit_roles'
    end
  end

  def reset_password
    unless current_user && (current_user == @user or admin? or god?)
      @reset = Reset.find_by_code(params[:code])
      if @reset and @reset.user == @user and @reset.no_status? :used
      elsif @reset and @reset.status? :used
        redirect_to welcome_url, :alert => "The key you are trying to use has already been used."
      else
        redirect_to welcome_url, :alert => "You are not authorized to access this page."
      end 
    end
  end

  def update_password
    if current_user && (current_user == @user or admin? or god?)
      if @user.update_attributes(params[:user])
        session[:user_id] = @user.id
        redirect_to root_url, :notice => join(changed(:password),notify(:logged_in))
      else
        render 'reset_password'
      end
    else
      @reset = Reset.find_by_code(params[:code])
      if @reset and @reset.user == @user and @reset.no_status? :used
        if @user.update_attributes(params[:user])
          @reset.status = "used"
          @reset.save
          session[:user_id] = @user.id
          redirect_to root_url, :notice => join(changed(:password),notify(:logged_in))
        else
          render 'reset_password'
        end
      elsif @reset and @reset.status? :used
        redirect_to welcome_url, :alert => "The key you are trying to use has already been used."
      else
        redirect_to welcome_url, :alert => "You are not authorized to access this page."
      end 
    end
  end

  private

    def load_opinions
      @opinions = Opinion.order("updated_at desc")
      @opinions = @opinions.where("user_id <> ?",current_user.id) if current_user
      @opinions = @opinions.limit(1)
    end

    def map_url
      "http://maps.google.com/maps/api/staticmap?" +
      [["size=400x130"],
       ["maptype=roadmap"],
       ["sensor=false"],
       ["center=#{@user.latitude},#{@user.longitude}"],
       ["zoom=12"],
       ["style=feature:all|element:all|saturation:-100"],
       ["markers=color:0xEE127B|#{@user.latitude},#{@user.longitude}"]].join("&")
    end
end

