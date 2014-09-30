class RemoveContentId < ActiveRecord::Migration
  def change
    remove_column :piles, :content_id, :integer
  end
end
