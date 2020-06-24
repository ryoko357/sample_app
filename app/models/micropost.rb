class Micropost < ApplicationRecord
  belongs_to :user
  # Default: foreign_key: user_id <-> User
  default_scope -> { self.order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end