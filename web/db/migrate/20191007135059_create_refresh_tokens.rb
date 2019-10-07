class CreateRefreshTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :refresh_tokens do |t|
      t.references :user, foreign_key: true, uniqueness: true
      t.string :token, null: false
      t.datetime :expiration, null: false

      t.timestamps
    end
  end
end
