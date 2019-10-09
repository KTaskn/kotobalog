class CreateSentences < ActiveRecord::Migration[5.2]
  def change
    create_table :sentences do |t|
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true
      t.string :sentence
      t.datetime :registration_date

      t.timestamps
    end
  end
end
