class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :book_id
      t.integer :user_id
      t.integer :village_id
      t.string :status
      t.string :memo
      t.text :history
      t.string :isbn13
      

      t.timestamps
    end
  end
end
