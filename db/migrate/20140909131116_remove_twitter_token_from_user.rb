class RemoveTwitterTokenFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :twitter_token, :string
    remove_column :users, :twitter_token_secret, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
end
