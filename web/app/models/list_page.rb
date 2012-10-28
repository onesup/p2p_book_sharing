class ListPage < ActiveRecord::Base
  attr_accessible :max_value, :min_value, :page, :url
end
