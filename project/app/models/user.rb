class User < ApplicationRecord
  has_many :blogs , :dependent => :destroy 
  has_many :comments , :dependent => :destroy 
  has_many :carts , :dependent => :destroy 
  has_many :star , :dependent => :destroy 
  has_many :books , :dependent => :destroy 
  

  
  
  has_many :order,:dependent => :destroy 
  
  
  validates_presence_of :username
  validates_presence_of :password
  
  def User.authenticate(name,password)
    if user=find_by("username":name)
      if user.password==password
        user
      end
    end
  end
end
