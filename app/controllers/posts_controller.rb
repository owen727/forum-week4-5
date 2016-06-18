class PostsController < ApplicationController

  def index
    # @posts = Post.all 
    @posts = Post.page(params[:page]).per(15)  #分頁設法
  end

  def new
    @post = Post.new

  end


  def create
    @post = Post.new(post_params)
    @post.save
      redirect_to @post
    
  end

  def show
    @post = Post.find(params[:id])
    
  end


  def edit
    @post = Post.find(params[:id])  
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path
    end


  end



  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path   
  end





  private

    def post_params
      params.require(:post).permit(:title, :content)
      
    end




end
