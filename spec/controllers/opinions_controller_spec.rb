require File.dirname(__FILE__) + '/../spec_helper'

def controller_actions(controller)
  Rails.application.routes.routes.inject({}) do |hash, route|
    hash[route.requirements[:action]] = route.verb.downcase if route.requirements[:controller] == controller && !route.verb.nil?
    hash
  end
end

describe OpinionsController do
  opinions_controller_actions = controller_actions("opinions")

  before(:each) do
    @opinion = Factory(:opinion, :user_id => Factory(:user).id)
  end

  describe "a user is not logged in" do
    opinions_controller_actions.each do |action,req|
      it "should not reach the #{action} page" do
        send("#{req}", "#{action}", :id => @opinion.id)
        response.redirect_url.should eq(welcome_url)
      end
    end
  end

  describe "a member is logged in" do
    before(:each) do
      user = Factory(:user, :roles_mask=>8)
      @own_opinion = Factory(:opinion, :user_id => user.id)
      session[:user_id] = user.id
    end
    
    opinions_controller_actions.each do |action,req|
      if %w(create).include?(action)
        it "should reach the #{action} page" do
          send("#{req}", "#{action}", :id => @opinion.id)
          response.redirect_url.should_not eq(welcome_url)
        end
      elsif %w(update).include?(action)
        it "should reach his own #{action} page" do
          send("#{req}", "#{action}", :id => @own_opinion.id)
          response.redirect_url.should_not eq(welcome_url)
        end
        it "should not reach other's #{action} page" do
          send("#{req}", "#{action}", :id => @opinion.id)
          response.redirect_url.should eq(welcome_url)
        end        
      else
        it "should not reach the #{action} page" do
          send("#{req}", "#{action}", :id => @opinion.id)
          response.redirect_url.should eq(welcome_url)
        end
      end
    end    
  end

  describe "a mini-admin is logged in" do
    before(:each) do
      @user = Factory(:user, :roles_mask=>4)
      session[:user_id] = @user.id
    end
    
    opinions_controller_actions.each do |action,req|
      if %w(create).include?(action)
        it "should reach the #{action} page" do
          send("#{req}", "#{action}", :id => @opinion.id)
          response.redirect_url.should_not eq(welcome_url)
        end
      else
        it "should not reach the #{action} page" do
          send("#{req}", "#{action}", :id => @opinion.id)
          response.redirect_url.should eq(welcome_url)
        end
      end
    end    
  end  

  describe "an admin is logged in" do
    before(:each) do
      session[:user_id] = Factory(:user, :roles_mask=>2).id
    end
    
    opinions_controller_actions.each do |action,req|
      if %w(create update).include?(action)
        it "should reach the #{action} page" do
          send("#{req}", "#{action}", :id => @opinion.id)
          response.redirect_url.should_not eq(welcome_url)
        end        
      else
        it "should not reach the #{action} page" do
          send("#{req}", "#{action}", :id => @opinion.id)
          response.redirect_url.should eq(welcome_url)
        end
      end      
    end    
  end

  describe "a god has come down to Earth" do
    before(:each) do
      session[:user_id] = Factory(:user, :roles_mask=>1).id
    end
    
    opinions_controller_actions.each do |action,req|
      it "should reach the #{action} page" do
        send("#{req}", "#{action}", :id => @opinion.id)
        response.redirect_url.should_not eq(welcome_url)
      end
    end    
  end  
end
