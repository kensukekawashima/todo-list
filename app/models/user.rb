class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { email.downcase! }
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow, dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user, dependent: :destroy
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

  # 自分でないことを確認後、followする
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  # もし、followしていたらfollow解除
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  # followしているかの確認
  def following?(other_user)
    self.followings.include?(other_user)
  end
end
