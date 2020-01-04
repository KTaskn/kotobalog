class CreateUserTwitterInfomations < ActiveRecord::Migration[5.2]
  def change
    create_table :user_twitter_infomations do |t|
      t.references :user, foreign_key: true
      t.string :twitter_id, unique: true

      t.timestamps
    end
  end
end
