class SentenceLike < ApplicationRecord
  validates :sentence, :uniqueness => {:scope => :user}

  belongs_to :sentence
  belongs_to :user
end
