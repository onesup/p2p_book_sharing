class CreateShelves < ActiveRecord::Migration
  def change
    create_table :shelves do |t|
      t.integer :book_id
      t.integer :user_id
      t.string :isbn13
      t.integer :village_id
      t.string :status
      t.string :memo
      t.text :history

      t.timestamps
    end
  end
end
