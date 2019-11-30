class AddIndexToSentenceLikesUserSentence < ActiveRecord::Migration[5.2]
  def change
    add_index :sentence_likes, [:user_id, :sentence_id], unique: true
  end
end
