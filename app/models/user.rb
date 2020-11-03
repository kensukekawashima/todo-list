class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { email.downcase! }
  has_many :tasks, dependent: :destroy
  validates :name, presence: true,length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,length: { minmum: 6,maximum: 255 },uniqueness: { case_sensitive: false },format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # 記憶トークンを作成
  def self.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 記憶ダイジェストを作成
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 上記2つを呼び出し、記憶ダイジェストをDBに記録
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # 記憶ダイジェストを削除
  def forget
    update_attribute(:remember_digest, nil)
  end
end
