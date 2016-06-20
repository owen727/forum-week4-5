class CommentsController < ApplicationController



  def index
    @comments = Comment.all 
    # @posts = Post.page(params[:page]).per(15)  #分頁設法
    # @post = Post.new

  end

  def show
  end


  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:description, :user_id))
    @comment.user_id = current_user.id if current_user
    @comment.save

    if @comment.save
      redirect_to post_path(@post)
    else
       render "new"
    end
  end



  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    render "posts/show"
  end

















end
