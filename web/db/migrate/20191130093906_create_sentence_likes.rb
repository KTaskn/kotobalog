class CreateSentenceLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :sentence_likes do |t|
      t.references :sentence, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
