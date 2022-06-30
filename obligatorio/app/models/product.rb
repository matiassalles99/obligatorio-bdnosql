class Product
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :price, type: Float

  validates :name, :description, :price, presence: true

  class << self
    def fillable
      %i[name description price]
    end
  end
end
