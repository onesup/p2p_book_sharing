class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :book_id
      t.string :user_id
      t.string :village_id
      t.string :status
      t.string :memo
      t.string :history
      t.string :isbn13

      t.timestamps
    end
  end
end
