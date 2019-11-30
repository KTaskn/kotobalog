class Sentence < ApplicationRecord
  validates :sentence, presence: true

  belongs_to :book
  belongs_to :user

  def islike(user)
    if SentenceLike.find_by(user: user) then
      return true
    else
      return false
    end
  end

  def like(user)
    like = SentenceLike.create(
      sentence: self,
      user: user
    )
    return like.save()
  end

  def unlike(user)
    like = SentenceLike.find_by(user: user)
    if like then
      if like.delete then
        return true
      else
        return false
      end
    else
      return false
    end
  end
end