class Reset < ActiveRecord::Base
  belongs_to :user

  attr_accessor :email
  attr_accessible :email

  before_create :save_user, :generate_code

  validates_presence_of :email, :on => :create
  validate :registered_email?, :on => :create

  STATUS = %w(used)

  def no_status?(stat); !(status? stat) end
  def status?(stat); status.include? stat.to_s end
  def status; STATUS.reject {|e| ((status_mask || 0) & 2**STATUS.index(e)).zero?} end
  def status=(stats)
    stats = stats.split(', ') if stats.instance_of? String
    self.status_mask = (stats & STATUS).map{|e| 2**STATUS.index(e)}.sum 
  end  

  private
    def generate_code; self.code = Digest::SHA1.hexdigest([ Time.now, rand].join) end
    def registered_email?
      errors.add(:email, I18n.t("alert.non_registered_email")) unless User.find_by_email(email)
    end
    def save_user; self.user_id = User.find_by_email(email).id end
end

# == Schema Information
#
# Table name: resets
#
#  id         :integer(4)      not null, primary key
#  code       :string(255)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

