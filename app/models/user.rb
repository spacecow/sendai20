# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  has_one :opinion

  # new columns need to be added here to be writable through mass assignment
  attr_accessible :email, :password, :password_confirmation, :name, :prefecture, :address

  attr_accessor :password, :prefecture, :address
  before_create :set_role
  before_save :prepare_password
  geocoded_by :full_address
  after_validation :geocode

  validates_presence_of :name
  validates_uniqueness_of :email, :allow_blank => true
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true

  ROLES = %w(god admin mini_admin member)
  PREFECTURES = ["北海道", "青森県", "秋田県", "岩手県", "新潟県", "山形県", "宮城県", "石川県", "富山県", "栃木県", "福島県", "福井県", "長野県", "群馬県", "埼玉県", "茨城県", "島根県", "鳥取県", "兵庫県", "京都府", "滋賀県", "岐阜県", "山梨県", "東京都", "千葉県", "山口県", "広島県", "岡山県", "大阪府", "奈良県", "愛知県", "静岡県", "神奈川県", "佐賀県", "福岡県", "和歌山県", "三重県", "長崎県", "熊本県", "大分県", "愛媛県", "香川県", "鹿児島県", "宮崎県", "高知県", "徳島県", "沖縄県"]

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

