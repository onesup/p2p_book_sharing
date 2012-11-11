class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :village_id
      t.string :seller_id
      t.string :buyer_id
      t.string :collection_id
      t.string :point
      t.string :mobile
      t.string :memo
      t.string :status

      t.timestamps
    end
  end
end
