class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :creator, null: false
      t.string :publisher

      t.timestamps
    end
  end
end
