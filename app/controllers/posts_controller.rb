class PostsController < ApplicationController

  before_action :authenticate_user!, :except =>[:index, :show ]
  before_action :find_post, :only => [:show, :edit, :update, :destroy] #設定當前post


  def index
    # @posts = Post.all 
    # @posts = Post.includes(:comments).order("comments.created_at desc").page(params[:page]).per(8)  #回應時間排序+分頁設法
    # @posts = Post.joins(:comments).group("posts.id").order("count(comments.id) desc").page(params[:page]).per(8) #回應數量排序+分頁設法 0回應會不見
    

    # if params[:order] == "comments.created_at desc" 
    #   sort_by = params[:order] 
    # elsif params[:order] == "created_at desc" 
    #   sort_by = params[:order] 
    # elsif params[:order] == "comments_count desc" 
    #   sort_by = params[:order]   
    # end

    case params[:order]
       when "comments.created_at desc" then 
       sort_by = params[:order]
       when "comments_count desc" then 
       sort_by = params[:order]
       else 
       sort_by = "created_at desc"
    end



    @posts = Post.includes(:comments).order(sort_by).page(params[:page]).per(8)
    @post = Post.new
    @user = current_user



  end

  def new
    @post = Post.new

  end


  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, :notice => 'New Post successfully created.'
    else
      render new_post_path
    end
  end

  def show
    @user = @post.user
  end


  def edit
  end


  def update    
    if @post.update(post_params)
      redirect_to post_path, :notice => 'Post successfully edited.'
    else
      render :action => :edit #為什麼 edit_post_path不行？  -> 因為要指定action不是path
    end
  end



  def destroy    
    @post.destroy

    redirect_to :back, #問設參數 :page = params[:page]) 的作法

    :alert => 'Post Deleted.'
  end


  



  private

    def find_post
       @post = Post.find(params[:id]) 
    end

    def post_params
      params.require(:post).permit(:title, :content, :user_id, :avatar)
      
    end




end
