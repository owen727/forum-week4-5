class LikesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_post
 

  def create
  
    @like = @post.find_my_like(current_user)

    unless @like
      @like = Like.create!( :post => @post, :user => current_user )
    end

    render "reload"
    
  end

   def destroy
     like = @post.likes.find( params[:id] )
     like.destroy
 
     @like = nil

     render "reload"

   end
 





   protected
 
   def set_post
     @post = Post.find( params[:post_id ])
   end
 



end
