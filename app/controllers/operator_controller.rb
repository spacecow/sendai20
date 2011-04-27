class OperatorController < ApplicationController
  def welcome
    @opinions = Opinion.all
    @opinions.reject!{|e| e.user_id == current_user.id} if current_user
    
    @opinion = (current_user && current_user.opinion) || Opinion.new
    
    @polled_opinions = Opinion.where("updated_at > ?", Time.at(params[:after].to_i))
    @polled_opinions.reject!{|e| e.user_id == current_user.id} if current_user
  end
end
