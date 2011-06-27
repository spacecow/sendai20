class ResetsController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    if @reset.save
      flash[:notice] = message :reset_instructions 
      ResetMailer.reset_confirmation(@reset).deliver
      redirect_to root_path
    else
      render "new"
    end
  end

end
