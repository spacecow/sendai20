require File.dirname(__FILE__) + '/../spec_helper'


describe UsersController do
  users_controller_actions = controller_actions("users")

  describe "a user is not logged in" do
    before(:each) do
      @user = Factory(:user)
    end
    
    users_controller_actions.each do |action,req|
      if %w(new create).include?(action)
        it "should reach the #{action} page" do
          send("#{req}", "#{action}", :id => @user.id)
          response.redirect_url.should_not eq(welcome_url)
        end
      else
        it "should not reach the #{action} page" do
          send("#{req}", "#{action}", :id => @user.id)
          response.redirect_url.should eq(welcome_url)
        end
      end
    end
  end

  describe "a member is logged in" do
    before(:each) do
      @own = Factory(:user, :roles_mask=>8)
      @other = Factory(:user)
      session[:user_id] = @own.id
    end
    
    users_controller_actions.each do |action,req|
      if %w(new create show).include?(action)
        it "should reach the #{action} page" do
          send("#{req}", "#{action}", :id => @other.id)
          response.redirect_url.should_not eq(welcome_url)
        end
      elsif %w(reset_password update_password edit update).include?(action)
        it "should reach his own #{action} page" do
          send("#{req}", "#{action}", :id => @own.id)
          response.redirect_url.should_not eq(welcome_url)
        end
        it "should not reach someone else's #{action} page" do
          send("#{req}", "#{action}", :id => @other.id)
          response.redirect_url.should eq(welcome_url)
        end            
      else
        it "should not reach the #{action} page" do
          send("#{req}", "#{action}", :id => @other.id)
          response.redirect_url.should eq(welcome_url)
        end
      end
    end    
  end

  describe "a mini-admin is logged in" do
    before(:each) do
      @own = Factory(:user, :roles_mask=>4)
      @other = Factory(:user)
      session[:user_id] = @own.id
    end
    
    users_controller_actions.each do |action,req|
      if %w(new create show index edit update).include?(action)
        it "should reach the #{action} page" do
          send("#{req}", "#{action}", :id => @other.id)
          response.redirect_url.should_not eq(welcome_url)
        end
      else
        it "should not reach the #{action} page" do
          send("#{req}", "#{action}", :id => @other.id)
          response.redirect_url.should eq(welcome_url)
        end
      end
    end    
  end  

  describe "an admin is logged in" do
    before(:each) do
      @own = Factory(:user, :roles_mask=>2)
      @other = Factory(:user)
      session[:user_id] = @own.id
    end
    
    users_controller_actions.each do |action,req|
      it "should reach the #{action} page" do
        send("#{req}", "#{action}", :id => @other.id)
        response.redirect_url.should_not eq(welcome_url)
      end
    end    
  end

  describe "a god has come down to Earth" do
    before(:each) do
      @own = Factory(:user, :roles_mask=>1)
      @other = Factory(:user)
      session[:user_id] = @own.id
    end
    
    users_controller_actions.each do |action,req|
      it "should reach the #{action} page" do
        send("#{req}", "#{action}", :id => @other.id)
        response.redirect_url.should_not eq(welcome_url)
      end
    end    
  end  
end
