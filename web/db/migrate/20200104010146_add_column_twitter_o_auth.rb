class AddColumnTwitterOAuth < ActiveRecord::Migration[5.2]
  def up
    add_column :twitter_oauths, :oauth_token, :string
    add_column :twitter_oauths, :oauth_token_secret, :string
    add_column :twitter_oauths, :twitter_id, :string
    add_column :twitter_oauths, :email, :string
  end

  def down
    remove_column :twitter_oauths, :oauth_token, :string
    remove_column :twitter_oauths, :oauth_token_secret, :string
    remove_column :twitter_oauths, :twitter_id, :string
    remove_column :twitter_oauths, :email, :string
  end
end
