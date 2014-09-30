class CreateContentsPiles < ActiveRecord::Migration
  def change
    create_table :contents_piles do |t|
      t.integer :content_id, :null => false
      t.integer :pile_id, :null => false

      t.timestamps
    end
  end
end
