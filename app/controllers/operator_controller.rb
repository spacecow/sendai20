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

  def scrollup
    @opinions = Opinion.order("updated_at asc")
    @opinions = @opinions.where("user_id <> ?",current_user.id) if current_user
    @opinions = @opinions.limit(10)

    @opinion = (current_user && current_user.opinion) || Opinion.new
    if current_user
      ids = Opinion.where("user_id <> ?", current_user.id).select(:id)
    else 
      ids = Opinion.select(:id)
    end
    offset = ids[rand(ids.count)].id
    @polled_opinion = Opinion.find(offset)
  end

  def movie
    @opinions = Opinion.order("updated_at desc")
    @opinions = @opinions.where("user_id <> ?",current_user.id) if current_user
    @opinions = @opinions.limit(1)
    
    @opinion = Opinion.new
    @opinion.content = current_user.opinion.content if current_user && current_user.opinion 
    if current_user
      ids = Opinion.where("user_id <> ?", current_user.id).select(:id)
    else 
      ids = Opinion.select(:id)
    end
    unless ids.empty?
      offset = ids[rand(ids.count)].id
      @polled_opinion = Opinion.find(offset)
    end

    @user = User.new
    #@user.city = request.location.city
  end
end
