class Order < ApplicationRecord
  belongs_to :user
  has_many :orderitem,:dependent => :destroy 
end
