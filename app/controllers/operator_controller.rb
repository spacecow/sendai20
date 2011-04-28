class OperatorController < ApplicationController
  def welcome
    @opinions = Opinion.order("updated_at desc")
    @opinions = @opinions.where("user_id <> ?",current_user.id) if current_user
    @opinions = @opinions.limit(5)
    
    @opinion = (current_user && current_user.opinion) || Opinion.new
    
    @polled_opinions = Opinion.where("updated_at > ?", Time.at(params[:after].to_i)).order("updated_at asc")
    @polled_opinions = @polled_opinions.where("user_id <> ?",current_user.id) if current_user
  end
end
