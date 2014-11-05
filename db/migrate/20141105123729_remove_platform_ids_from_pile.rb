class RemovePlatformIdsFromPile < ActiveRecord::Migration
  def change
    remove_column :piles, :platform_ids, :string
  end
end
