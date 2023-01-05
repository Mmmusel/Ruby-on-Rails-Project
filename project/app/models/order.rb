class Order < ApplicationRecord
  belongs_to :user
  has_many :orderitem,:dependent => :destroy 
  
  
  validates_presence_of :order_name
  validates_presence_of :order_address
  validates_presence_of :order_mobile
  
  validates :order_mobile, presence: true, format: { with: /\A(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}\z/ }
  
end
