class Collection < ActiveRecord::Base
  has_many :deals
  belongs_to :book
  belongs_to :village
  belongs_to :user
  
  attr_accessible :book_id, :history, :memo, :status, :user_id, :village_id
end
