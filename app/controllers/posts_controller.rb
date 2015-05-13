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
    @tags = Tag.all
  end

  def create
    if tag_list_nil?
      flash.notice = "Please select at least one tag"
      redirect_to root_path
    else
      create_tags
      @post = Post.new(post_params)
      if @post.save
        @post.tags = @found_tags
        flash.notice = "#{@post.title} Post created!"
        redirect_to root_path
      else
        flash.notice = "oh no, something went wrong, please try again."
        render :new
      end
    end
  end

  def tag_list_nil?
    params[:tag_list] == nil
  end

  def create_tags
    string_tags = params[:tag_list][:tags].uniq
    @found_tags = string_tags.map do |name|
      Tag.find_or_create_by(name: name)
    end
  end

  def update
    if tag_list_nil?
      flash.notice = "Please select at least one tag"
      redirect_to root_path
    else
      create_tags
      @post = Post.find(params[:id])
      @post.update(post_params)
      if @post.save
        @post.tags = @found_tags
        flash.notice = "#{@post.title} Post updated!"
        redirect_to root_path
      else
        flash.notice = "oh no, something went wrong, please try again."
        render :new
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tags = Tag.all
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
