class CreateTwitterOauths < ActiveRecord::Migration[5.2]
  def change
    create_table :twitter_oauths do |t|

      t.timestamps
    end
  end
end
