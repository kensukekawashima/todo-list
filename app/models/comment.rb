class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :comment, presence: true, length: {maximum: 50}
  validates :user, presence: true
  validates :task, presence: true
end
