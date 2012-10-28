class BookUrl < ActiveRecord::Base
  attr_accessible :author, :published_at, :title, :url
end
