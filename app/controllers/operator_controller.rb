class OperatorController < ApplicationController
  def welcome
    @opinions = Opinion.order("updated_at desc")
    @opinions = @opinions.where("user_id <> ?",current_user.id) if current_user
    @opinions = @opinions.limit(10)
    
    @opinion = (current_user && current_user.opinion) || Opinion.new
    if current_user
      ids = Opinion.where("user_id <> ?", current_user.id).select(:id)
    else 
      ids = Opinion.select(:id)
    end
    unless ids.empty?
      offset = ids[rand(ids.count)].id
      @polled_opinion = Opinion.find(offset)
    end
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
    @opinions = Opinion.order("updated_at asc")
    @opinions = @opinions.where("user_id <> ?",current_user.id) if current_user
    @opinions = @opinions.limit(10)

    if current_user
      ids = Opinion.where("user_id <> ?", current_user.id).select(:id)
    else 
      ids = Opinion.select(:id)
    end
    offset = ids[rand(ids.count)].id
    @polled_opinion = Opinion.find(offset)
  end
end
