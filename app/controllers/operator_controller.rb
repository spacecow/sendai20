class OperatorController < ApplicationController
  def welcome
    @opinions = Opinion.order("updated_at desc")
    @opinions = @opinions.where("user_id <> ?",current_user.id) if current_user
    @opinions = @opinions.limit(5)
    
    @opinion = (current_user && current_user.opinion) || Opinion.new
    
    #@polled_opinions = Opinion.where("updated_at > ?", Time.at(params[:after].to_i)).order("updated_at asc")

    size = Opinion.count
    if current_user
      @polled_opinions = Opinion.where("user_id <> ?",current_user.id)
      @polled_opinions = @polled_opinions.all(:offset => rand(size),:limit => 1)
    else
      @polled_opinions = Opinion.all(:offset => rand(size),:limit => 1)
    end

    #@polled_opinions = @polled_opinions.limit(5)
  end

  def welcome_up
    @opinions = Opinion.order("updated_at desc")
    @opinions = @opinions.where("user_id <> ?",current_user.id) if current_user
    @opinions = @opinions.limit(5)
    
    @opinion = (current_user && current_user.opinion) || Opinion.new
    
    size = Opinion.count
    if current_user
      @polled_opinions = Opinion.where("user_id <> ?",current_user.id)
      @polled_opinions = @polled_opinions.all(:offset => rand(size),:limit => 1)
    else
      @polled_opinions = Opinion.all(:offset => rand(size),:limit => 1)
    end
  end

  def scrollup
    @opinions = Opinion.order("updated_at desc")
    @opinions = @opinions.where("user_id <> ?",current_user.id) if current_user
    @opinions = @opinions.limit(5)
  end
end
