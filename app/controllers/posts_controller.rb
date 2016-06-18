class PostsController < ApplicationController

  before_action :find_post, :only => [:show, :edit, :update, :destroy] 
  #設定當前post


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
    
    
  end


  def edit
      
  end

  def update
    
    if @post.update(post_params)
      redirect_to post_path
    end


  end



  def destroy
    
    @post.destroy
    redirect_to posts_path   
  end





  private

    def find_post
       @post = Post.find(params[:id]) 
    end

    def post_params
      params.require(:post).permit(:title, :content)
      
    end




end
