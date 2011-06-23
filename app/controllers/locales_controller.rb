class LocalesController < ApplicationController
  load_and_authorize_resource

  def create
    if @locale.save
      redirect_to translations_path, :notice => created(:locale)
    else
      initialize_page
      render '/translations/index'
    end
  end

  def update
    if @locale.update_attributes(params[:locale])
      redirect_to translations_path, :notice => updated(:locale)
    else
      initialize_page
      render '/translations/index'
    end
  end

  private

    def initialize_page
      @translation = Translation.new
      @translations = $redis 
      @locales = Locale.all
    end
end
