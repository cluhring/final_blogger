class PostsController < ApplicationController
  def index
    @posts = Post.all
    @tags = Tag.all
  end

  def drafted
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash.notice = "#{@post.title} Post created!"
      redirect_to root_path
    else
      flash.notice = "oh no, something went wrong, please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash.notice = "#{@post.title} Post updated!"
      redirect_to root_path
    else
      flash.notice = "oh no, something went wrong, please try again."
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash.notice = "#{@post.title} Post has been deleted."
      redirect_to root_path
    else
      flash.notice = "oh no, something went wrong, please try again."
      redirect_to root_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :author, :status, :image)
  end
end
