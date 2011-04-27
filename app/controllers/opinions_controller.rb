class OpinionsController < ApplicationController
  before_filter :create_user_opinion, :only => :create
  load_and_authorize_resource

  def index
    @opinions = Opinion.all
  end

  def show
  end

  def new
  end

  def create
    if @opinion.save
      flash[:notice] = saved(:opinion)
    else
      flash[:alert] = "Opinion cannot be saved blank."
    end
    respond_to do |f|
      f.html {redirect_to root_path}
      f.js
    end    
  end

  def edit
  end

  def update
    if @opinion.update_attributes(params[:opinion])
      flash[:notice] = updated(:opinion)
    else
      flash[:alert] = "Opinion cannot be saved blank."
    end
    respond_to do |f|
      f.html {redirect_to root_path}
      f.js
    end
  end

  def destroy
    @opinion.destroy
    redirect_to opinions_url, :notice => deleted(:opinion)
  end

  private

    def create_user_opinion; @opinion = current_user.build_opinion(params[:opinion]) if current_user end
end
