class Deal < ActiveRecord::Base
  belongs_to :seller, :class_name => 'User', :foreign_key => 'seller_id'
  belongs_to :buyer, :class_name => 'User', :foreign_key => 'buyer_id'
  belongs_to :collection
  attr_accessible :buyer_id, :collection_id, :point, :seller_id, :status, :memo, :mobile
end
