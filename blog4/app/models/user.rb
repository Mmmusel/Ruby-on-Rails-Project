class User < ApplicationRecord
  has_many :blogs
  has_many :comments


  def User.authenticate(name,password)
    if user=find_by("username":name)
      if user.password==password
        user
      end
    end
  end
end
