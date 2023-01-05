class Book < ApplicationRecord
  belongs_to :user
  
    validates_presence_of :bookname
  validates_presence_of :bookaddress
  validates_presence_of :bookmobile
  
  validates :bookmobile, presence: true, format: { with: /\A\d{11}\z/ }
end
