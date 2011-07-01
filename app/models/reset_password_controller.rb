module ResetPasswordController
  def change_password
    if current_user && (current_user == @user or admin? or god?)
      redirect_to edit_user_path(current_user)
    else
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
        render 'edit'
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
          render 'change_password'
        end
      elsif @reset and @reset.status? :used
        redirect_to welcome_url, :alert => "The key you are trying to use has already been used."
      else
        redirect_to welcome_url, :alert => "You are not authorized to access this page."
      end 
    end
  end
end
