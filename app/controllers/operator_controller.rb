class OperatorController < ApplicationController
  def welcome
    @opinions = Opinion.all
    @opinions.reject!{|e| e.user_id == current_user.id} if current_user
    @opinion = Opinion.new
  end
end
