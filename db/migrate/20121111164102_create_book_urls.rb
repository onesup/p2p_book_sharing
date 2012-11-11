class CreateBookUrls < ActiveRecord::Migration
  def change
    create_table :book_urls do |t|
      t.string :url
      t.string :title

      t.timestamps
    end
  end
end
