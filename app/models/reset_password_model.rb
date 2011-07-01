module ResetPasswordModel
  def self.included(base)
    base.send :attr_accessible, :old_password, :update_password, :update_password_with_key
    base.send :attr_accessor, :old_password, :update_password, :update_password_with_key
    base.send :validates_presence_of, :password, :if => :update_password
    base.send :validates_presence_of, :password, :if => :update_password_with_key
    base.send :validate, :old_password_check, :if => :update_password
  end

  private

    def old_password_check
      errors.add(:old_password, I18n.t("error.doesnt_match")) unless self.password_hash == encrypt_password(old_password)
    end
end

#ActiveRecord::Base.send :include, ResetPasswordModel
