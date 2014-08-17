class RemoveTypeFromContents < ActiveRecord::Migration
  def change
    remove_column :contents, :type, :string
  end
end
