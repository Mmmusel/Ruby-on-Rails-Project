class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments , :dependent => :destroy  
  has_many :carts , :dependent => :destroy 
  has_many :star , :dependent => :destroy 
  validates :title, :content,  presence: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
  
  validates :stock, numericality: { less_than_or_equal_to: 99999, only_integer: true }
  
  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :stock
  validates_presence_of :price
end
