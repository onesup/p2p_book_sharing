class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :village_id
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :collection_id
      t.integer :point
      t.string :mobile
      t.string :memo
      t.string :status

      t.timestamps
    end
  end
end
