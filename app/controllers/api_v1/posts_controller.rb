class ApiV1::PostsController < ApiController

  # GET /api/v1/topics/:id
  def show
    @post = Post.find(params[:id])

    # show.json.jbuilder
  end

  # GET /api/v1/topics
  def index
    @posts = Post.page( params[:page] ).per(5)

    # index.json.jbuilder
  end


end
