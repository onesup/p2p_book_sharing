class AddCollectionId < ActiveRecord::Migration
  def up
    add_column :books, :collection_id, :integer
  end

  def down
    remove_column :books, :collection_id
  end
end
