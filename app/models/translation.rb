class Translation < ActiveRecord::Base
  belongs_to :locale

  attr_accessible :locale_id, :key, :value

  validates_presence_of :key, :value, :locale_id

  def initialize_from_redis(key)
    self.locale = Locale.find_by_title(key.split('.')[0..-2].join('.'))
    self.key = key.split('.')[-1]
    self.value = I18n.t(key.split('.')[1..-1].join('.'))
    self
  end
end

# == Schema Information
#
# Table name: translations
#
#  id         :integer(4)      not null, primary key
#  locale_id  :integer(4)
#  key        :string(255)
#  value      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

