class Order < ApplicationRecord
  belongs_to :user
  has_many :orderitem,:dependent => :destroy 
  
  
  validates_presence_of :order_name
  validates_presence_of :order_address
  validates_presence_of :order_mobile
  
  validates :order_mobile, presence: true, format: { with: /\A\d{11}\z/ }
  
end
