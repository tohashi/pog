class RemoveColumnFromPiles < ActiveRecord::Migration
  def change
    remove_column :piles, :platform, :string
    add_column :piles, :platform_id, :integer, :null => false
  end
end
