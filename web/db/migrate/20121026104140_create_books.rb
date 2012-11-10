class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :url
      t.string :title
      t.string :foreign_title
      t.string :first_category
      t.string :second_category
      t.string :authors
      t.string :main_author
      t.string :publisher
      t.datetime :published_at
      t.string :language
      t.string :size
      t.integer :last_page
      t.string :isbn10
      t.string :isbn13
      t.integer :price
      t.integer :reviewed
      t.text :description
      t.text :index
      t.string :series
      t.timestamps
    end

    add_index :books, :title
    add_index :books, :series
    add_index :books, :isbn13
    add_index :books, :main_author
  end
end
