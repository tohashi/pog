class ChangeColumnDefaultFrom < ActiveRecord::Migration
  def change
    change_column_default :users, :authority, 1
  end
end
