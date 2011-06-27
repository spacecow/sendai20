class Locale < ActiveRecord::Base
  has_many :translations

  validates :title, :presence => true
end

# == Schema Information
#
# Table name: locales
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

