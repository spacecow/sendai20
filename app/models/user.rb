class User < ActiveRecord::Base
  has_one :opinion

  # new columns need to be added here to be writable through mass assignment
  attr_accessible :email, :password, :password_confirmation, :name, :address

  attr_accessor :password, :city
  before_create :set_role
  before_save :prepare_password
  geocoded_by :address
  after_validation :geocode

  validates_presence_of :name
  validates_uniqueness_of :email, :allow_blank => true
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true

  ROLES = %w(god admin mini_admin member)

  def role?( role ); roles.include? role.to_s end
  def role_symbols; roles.map(&:to_sym) end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end
  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end
  def set_role; self.roles = ["member"] if self.roles.empty? end
  
  def self.authenticate(login, pass)
    user = find_by_email(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
end



# == Schema Information
#
# Table name: users
#
#  id            :integer(4)      not null, primary key
#  email         :string(255)
#  roles_mask    :integer(4)
#  password_hash :string(255)
#  password_salt :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  name          :string(255)
#  latitude      :float
#  longitude     :float
#  address       :string(255)
#

