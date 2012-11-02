class Collection < ActiveRecord::Base
  has_many :books
  attr_accessible :book_id, :history, :memo, :status, :user_id, :village_id
end
