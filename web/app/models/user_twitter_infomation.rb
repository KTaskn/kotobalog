class UserTwitterInfomation < ApplicationRecord
  validates :user, uniqueness: true
  validates :twitter_id, uniqueness: true
  belongs_to :user
end
