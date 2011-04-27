class OperatorController < ApplicationController
  def welcome
    @opinions = Opinion.all
    @opinions.reject!{|e| e.user_id == current_user.id} if current_user
    @opinion = Opinion.new

    @polled_opinions = Opinion.where("created_at > ?", Time.at(params[:after].to_i))
  end
end
