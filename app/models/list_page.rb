class ListPage < ActiveRecord::Base
  attr_accessible :category, :max_value, :min_value, :page, :page_action, :url
end
