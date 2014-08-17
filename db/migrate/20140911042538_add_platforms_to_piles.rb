class AddPlatformsToPiles < ActiveRecord::Migration
  def change
    add_column :piles, :platform_ids, :string, :null => false
  end
end
