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
      redirect_to welcome_path, :notice => saved(:opinion)
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @opinion.update_attributes(params[:opinion])
      redirect_to @opinion, :notice  => saved(:opinion)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @opinion.destroy
    redirect_to opinions_url, :notice => deleted(:opinion)
  end

  private

    def create_user_opinion; @opinion = current_user.build_opinion(params[:opinion]) end
end
