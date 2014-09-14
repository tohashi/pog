class AddStatusToPiles < ActiveRecord::Migration
  def change
    remove_column :piles, :done, :boolean
    add_column :piles, :status, :integer, :null => false, :default => 0
  end
end
