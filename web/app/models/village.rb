class Village < ActiveRecord::Base
  attr_accessible :code, :dong, :gu, :si, :village
  has_many :users
  has_many :collections

end
