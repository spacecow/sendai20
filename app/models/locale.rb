class Locale < ActiveRecord::Base
  has_many :translations

  validates :title, :presence => true
end
