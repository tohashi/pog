class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :default => 'guest', :null => false
      t.string :twitter_token
      t.string :twitter_token_secret
      t.integer :authority, :default => 0, :null => false

      t.timestamps
    end
  end
end
