class OperatorController < ApplicationController
  def welcome
    @opinions = Opinion.order("updated_at asc")
    @opinions.reject!{|e| e.user_id == current_user.id} if current_user
    
    @opinion = (current_user && current_user.opinion) || Opinion.new
    
    @polled_opinions = Opinion.where("updated_at > ?", Time.at(params[:after].to_i)).order("updated_at asc")
    @polled_opinions.reject!{|e| e.user_id == current_user.id} if current_user
  end
end
