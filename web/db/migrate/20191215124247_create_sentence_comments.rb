class CreateSentenceComments < ActiveRecord::Migration[5.2]
  def change
    create_table :sentence_comments do |t|
      t.references :sentence, foreign_key: true, unique: true
      t.string :comment

      t.timestamps
    end
  end
end
