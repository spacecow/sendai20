class TranslationsController < ApplicationController
  load_and_authorize_resource

  def index
    @translation = params[:key].blank? ? Translation.new : Translation.new.initialize_from_redis(params[:key])
    @translations = $redis 
    @locales = Locale.all
    @locale = params[:locale].blank? ? Locale.new : Locale.find_by_title(params[:locale].split('.')[0..-2].join('.'))
  end

  def create
    @translation = Translation.new(params[:translation])
    if @translation.valid?
      locale = @translation.locale
      I18n.backend.store_translations(@translation.locale.title, {@translation.key => @translation.value}, :escape => false)
      redirect_to translations_url, :notice => added(:translation)
    else
      @translations = $redis
      @locales = Locale.all
      @locale = Locale.new
      render :index
    end
  end

  def delete
    $redis.del(params[:key])
    redirect_to translations_path
  end
end
