class Shelf < ActiveRecord::Base
  attr_accessible :book_id, :history, :isbn13, :memo, :status, :user_id, :village_id
end
