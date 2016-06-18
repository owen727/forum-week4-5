class PostsController < ApplicationController

  before_action :find_post, :only => [:show, :edit, :update, :destroy] #設定當前post


  def index
    # @posts = Post.all 
    @posts = Post.page(params[:page]).per(15)  #分頁設法
  end

  def new
    @post = Post.new

  end


  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, :notice => 'New Post successfully created.'
    else
      render new_post_path
    end
  end

  def show
  end


  def edit
  end


  def update    
    if @post.update(post_params)
      redirect_to post_path, :notice => 'Post successfully edited.'
    else
      render :action => :edit #為什麼 edit_post_path不行？
    end
  end



  def destroy    
    @post.destroy
    redirect_to posts_path, :alert => 'Post Deleted.'
  end






  private

    def find_post
       @post = Post.find(params[:id]) 
    end

    def post_params
      params.require(:post).permit(:title, :content)
      
    end




end
