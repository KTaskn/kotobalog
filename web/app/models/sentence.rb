class Sentence < ApplicationRecord
  validates :sentence, presence: true

  belongs_to :book
  belongs_to :user
end
