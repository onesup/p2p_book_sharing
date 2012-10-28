class CreateListPages < ActiveRecord::Migration
  def change
    create_table :list_pages do |t|
      t.string :url
      t.integer :page
      t.string :min_value
      t.string :max_value
      t.string :page_action

      t.timestamps
    end
  end
end
