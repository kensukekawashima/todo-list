class User < ApplicationRecord
  before_save { email.downcase! }
  has_many :tasks, dependent: :destroy
  validates :name, presence: true,length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,length: { minmum: 6,maximum: 255 },uniqueness: { case_sensitive: false },format: { with: VALID_EMAIL_REGEX }
  has_secure_password
end
