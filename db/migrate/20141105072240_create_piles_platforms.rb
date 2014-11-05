class CreatePilesPlatforms < ActiveRecord::Migration
  def change
    create_table :piles_platforms do |t|
      t.references :pile, index: true
      t.references :platform, index: true

      t.timestamps
    end
  end
end
