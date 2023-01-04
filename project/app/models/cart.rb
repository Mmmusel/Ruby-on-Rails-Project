class Cart < ApplicationRecord
  belongs_to :blog
  belongs_to :user
end
