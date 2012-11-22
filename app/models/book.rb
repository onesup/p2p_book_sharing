class Book < ActiveRecord::Base
  has_many :collection
  
  attr_accessible :main_author, :authors, :description, :first_category, :index, :isbn10, :isbn13, :language, :last_page, :price, :published_at, :publisher, :reviewed, :second_category, :series, :size, :title
  serialize :authors

  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  def self.search(params)
    tire.search(page: params[:page], per_page: 5) do
      query { string params[:query], default_operator: "AND" } if params[:query].present?
    end
  end
  
  # def self.search(search)
  #   if search
  #     t = Book.arel_table
  #     q = t[:title].matches('%'+search+'%')
  #     # q = q.or(t[:series].matches('%'+search+'%'))
  #     # q = q.or(t[:main_author].eq(search))
  #     Book.where(q)
  #   else
  #     limit(5).order("create_at desc")
  #   end
  # end
end
