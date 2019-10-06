class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, uniqueness: true, null: false
      t.string :email, uniqueness: true, null: false
      t.string :password_digest, null:false

      t.timestamps
    end
  end
end
