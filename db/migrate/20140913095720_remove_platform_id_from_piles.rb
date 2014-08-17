class RemovePlatformIdFromPiles < ActiveRecord::Migration
  def change
    remove_column :piles, :platform_id, :integer
    change_column :piles, :platform_ids, :string, :null => false
  end
end
