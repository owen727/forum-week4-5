class Category < ActiveRecord::Base

  has_many :category_ships
  has_many :posts , :through => :category_ships

end
