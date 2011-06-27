class Reset < ActiveRecord::Base
  attr_accessor :email
  attr_accessible :email

  before_create :save_user, :generate_code

  validates_presence_of :email
  validate :registered_email?

  private
    def generate_code; self.code = Digest::SHA1.hexdigest([ Time.now, rand].join) end
    def registered_email?
      errors.add(:email, "not a registered email") unless User.find_by_email(email)
    end
    def save_user; self.user_id = User.find_by_email(email).id end
end
