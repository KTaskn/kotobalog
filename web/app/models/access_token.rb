require 'securerandom'

class AccessToken < ApplicationRecord
  belongs_to :user
  validates :user, uniqueness: true

  ADD_TIME = 1.hours
  def self.refresh(user, base_expiration=Time.zone.now)
    
    # 過去のトークンがある場合、削除
    old_token = self.find_by(user: user)
    if old_token then
      old_token.destroy()
    end

    token_str = SecureRandom.base64(36)
    expiration = base_expiration + ADD_TIME

    # 新しいトークンを生成
    token = self.new(
      user: user,
      token: token_str,
      expiration: expiration
    )
    token.save()

    return token
  end

  def check(token_str)
    return self.token == token_str
  end

  def remove
    return self.destroy()
  end
end
