require File.dirname(__FILE__) + '/../spec_helper'

describe Opinion do
  it "should be valid" do
    Opinion.new.should be_valid
  end
end


# == Schema Information
#
# Table name: opinions
#
#  id         :integer(4)      not null, primary key
#  content    :text
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

