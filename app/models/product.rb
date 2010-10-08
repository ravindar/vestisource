class Product < ActiveRecord::Base
  validates :productId,  :presence => true
  validates :imageURL,  :presence => true
  validates :name, :presence => true,
                    :length => { :minimum => 5 }

  has_many :comments
end
