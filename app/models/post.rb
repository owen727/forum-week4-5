class Post < ActiveRecord::Base

  belongs_to :user
  has_many :comments, :dependent => :delete_all

    validates :title, 
      :presence => true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, 
  default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/


  def comments_count
    @count = Post.find(params[:id]).comments.ids.count
  end


end
