# coding : utf-8

class Village < ActiveRecord::Base
  attr_accessible :code, :dong, :gu, :si, :village
  has_many :users
  has_many :collections
    
  def self.si_list
    ["서울시", "경기", "인천시", "강원", 
      "대전시", "충북", "충남", 
      "대구시", "경북","경남", "울산시", "부산시", 
      "광주시", "전북", "전남", "제주"]
  end
  
  def self.gu_list(si)
    self.where(:si => si).group(:gu)
  end
  
  def self.dong_list(si, gu)
    list = [si, gu]
    t = Village.arel_table
    q = t[:si].eq(si)
    q = q.and(t[:gu].eq(gu))
    Village.where(q).group(:dong)
  end
  
  def self.village_list(si, gu, dong)
    t = Village.arel_table
    q = t[:si].eq(si)
    q = q.and(t[:gu].eq(gu))
    q = q.and(t[:dong].eq(dong))
    Village.where(q)
  end

end
