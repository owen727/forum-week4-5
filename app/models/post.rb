class Post < ActiveRecord::Base

  belongs_to :user
  has_many :comments, :dependent => :delete_all
  has_many :category_ships
  has_many :categories , :through => :category_ships

  has_many :likes
  has_many :liked_users, :through => :likes, :source => :user


    validates :title, 
      :presence => true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, 
  default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/


  def comments_count
    @count = Post.find(params[:id]).comments.ids.count
  end


  def find_my_like(user)
    self.likes.where( :user => user ).first
  end



end
