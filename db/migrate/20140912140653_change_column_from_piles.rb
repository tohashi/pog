class ChangeColumnFromPiles < ActiveRecord::Migration
  def change
    change_column :piles, :platform_id, :integer, :null => true
  end
end
