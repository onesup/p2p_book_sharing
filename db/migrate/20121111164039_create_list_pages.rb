class CreateListPages < ActiveRecord::Migration
  def change
    create_table :list_pages do |t|
      t.string :category
      t.string :url
      t.string :page
      t.string :min_value
      t.string :max_value
      t.string :page_action

      t.timestamps
    end
  end
end
