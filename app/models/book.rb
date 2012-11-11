class Book < ActiveRecord::Base
  attr_accessible :authors, :description, :foreign_titlefirst_category, :index_page, :isbn10, :isbn13, :language, :last_page, :main_author, :price, :published_at, :publisher, :reviewed, :second_category, :series, :size, :title, :url
end
