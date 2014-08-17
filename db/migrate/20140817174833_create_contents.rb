class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :name, :null => false
      t.integer :type, :default => 1

      t.timestamps
    end
  end
end
