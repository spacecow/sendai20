require File.dirname(__FILE__) + '/../spec_helper'

describe LocalesController do
  controller_actions = controller_actions("locales")

  before(:each) do
    @locale = Factory(:locale)
  end

  describe "a user is not logged in" do
    controller_actions.each do |action,req|
      if %w().include?(action)
        it "should reach the #{action} page" do
          send("#{req}", "#{action}", :id => @locale.id)
          response.redirect_url.should_not eq(login_url)
        end
      else
        it "should not reach the #{action} page" do
          send("#{req}", "#{action}", :id => @locale.id)
          response.redirect_url.should eq(login_url)
        end
      end
    end
  end

  describe "an admin is logged in" do
    before(:each) do
      @user = Factory(:user, :roles_mask => 2)
      session[:user_id] = @user.id
    end
    
    controller_actions.each do |action,req|
      if %w(create update).include?(action)
        it "should reach the #{action} page" do
          send("#{req}", "#{action}", :id => @locale.id)
          response.redirect_url.should_not eq(welcome_url)
        end
      else
        it "should not reach the #{action} page" do
          send("#{req}", "#{action}", :id => @locale.id)
          response.redirect_url.should eq(welcome_url)
        end
      end
    end    
  end
end
