class PostsController < ApplicationController

  before_action :authenticate_user!, :except =>[:index, :show ]
  before_action :find_post, :only => [:show, :edit, :update, :destroy] #設定當前post


  def index

    ## TODO2
    # Remove all comments
    # Commit your code!

    # @posts = Post.all 
    # @posts = Post.includes(:comments).order("comments.created_at desc").page(params[:page]).per(8)  #回應時間排序+分頁設法
    # @posts = Post.joins(:comments).group("posts.id").order("count(comments.id) desc").page(params[:page]).per(8) #回應數量排序+分頁設法 0回應會不見
    # @posts = Post.includes(:comments).references(:comments).group("posts.id").order("count(comments.id) desc").page(params[:page]).per(8) #回應數量排序+分頁設法 0回應解決

    # if params[:order] == "comments.created_at desc" 
    #   sort_by = params[:order] 
    # elsif params[:order] == "created_at desc" 
    #   sort_by = params[:order] 
    # elsif params[:order] == "comments_count desc" 
    #   sort_by = params[:order]   
    # end

    # 依照分類篩選文章(預留)
    
    # if params[:sort] && params[:sort] == "Fun"
    #    @posts = Category.find_by(:name => "Fun").posts
    #  elsif params[:sort] && params[:sort] == "Angry"
    #    @posts = Category.find_by(:name => "Angry").posts
    #  elsif params[:sort] && params[:sort] == "Share"
    #    @posts = Category.find_by(:name => "Share").posts
    # end
    
    case params[:order]
       when "comments.created_at desc" then 
       sort_by = params[:order]
       when "comments_count desc" then 
       sort_by = params[:order]
       else 
       sort_by = "created_at desc"
    end

    @posts = Post.includes(:comments).order(sort_by)


    case params[:sort]
       
       when "Fun" then 
       @posts = Category.find_by(:name => "Fun").posts
       when "Angry" then 
       @posts = Category.find_by(:name => "Angry").posts
       when "Share"
       @posts = Category.find_by(:name => "Share").posts
      
    end
  
    @posts = @posts.page(params[:page]).per(8)
    

    unless params[:post_id] == nil
      @post = Post.find(params[:post_id])
    else 
      @post = Post.new
    end 
        
    @user = current_user

    # @category1 = Category.first.posts
    # @category2 = Category.second.posts
    # @category3 = Category.last.posts


    # case params[:category_id]
    #   when 1
    #     @category = @category1
    #   when 2
    #     @category = @category2
    #   when 3
    #     @category = @category3 
    # end  
  end

  def new
    @post = Post.new
  end


  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, :notice => 'New Post successfully created.'
    else
      @posts = Post.includes(:comments).page(params[:page]).per(8)
      render "index" # index.html.erb
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
    
    redirect_to posts_path(:page => params[:page]),  #設參數 :page = params[:page]) 的作法    #redirect_to :back,  直接back作法 會有一點問題
    
    :alert => 'Post Deleted.'
  
  end


  def about
    @users = User.all
    @posts = Post.all
    @comments = Comment.all
  end


  def profile
   @posts = current_user.posts
   @comments = Comment.all
  end



  private

    def find_post
       @post = Post.find(params[:id]) 
    end

    def post_params
      params.require(:post).permit(:title, :content, :user_id, :avatar, :category_ids => [])
    end




end
