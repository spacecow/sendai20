class Opinion < ActiveRecord::Base
  belongs_to :user

  attr_accessible :content, :user_id

  validates :user_id, :presence => true
  validates :content, :presence => true
  
  def username; user.username end
  def user_name; user.name end
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

