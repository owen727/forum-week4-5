class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, :only => [:show, :new, :edit, :create, :destroy] #設定當前post



  def index
    @comments = Comment.all 
    # @posts = Post.page(params[:page]).per(15)  #分頁設法
    # @post = Post.new

  end

  def show
  end

  def new
    
    @comment = Comment.new
  end

  def create
    
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
    
    @comment = @post.comments.find(params[:id])

    @comment.destroy
    
    render "posts/show"

  end

  # TODO3
  # 1. add before_action Done
  # 2. check if comment's user == current_user in destroy action  done    (add a before_action for create and destroy action     )




  private

  def find_post
    @post = Post.find(params[:post_id]) 
  end











end
