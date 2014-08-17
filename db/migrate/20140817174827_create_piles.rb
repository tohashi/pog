class CreatePiles < ActiveRecord::Migration
  def change
    create_table :piles do |t|
      t.integer :user_id, :null => false
      t.integer :content_id, :null => false
      t.string :platform
      t.string :memo
      t.boolean :done, :default => false, :null => false

      t.timestamps
    end
  end
end
