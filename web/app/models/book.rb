class Book < ActiveRecord::Base
  belongs_to :collection
  attr_accessible :main_author, :authors, :description, :first_category, :index, :isbn10, :isbn13, :language, :last_page, :price, :published_at, :publisher, :reviewed, :second_category, :series, :size, :title
  serialize :authors
end
