class SentenceComment < ApplicationRecord
  belongs_to :sentence
  validates :sentence, uniqueness: true
end
