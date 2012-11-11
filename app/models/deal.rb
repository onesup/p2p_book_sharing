class Deal < ActiveRecord::Base
  attr_accessible :buyer_id, :collection_id, :memo, :mobile, :point, :seller_id, :status, :village_id
end
