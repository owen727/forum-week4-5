class Comment < ActiveRecord::Base

  belongs_to :post, :counter_cache => true
  belongs_to :user


  validates :description, 
      :presence => true


end
