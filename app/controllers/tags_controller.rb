class TagsController < ApplicationController
  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash.notice = "Thanks for making a new #{@tag.name} tag."
      redirect_to root_path
    else
      flash.notice = "oh no, you failed to create a tag, please try again."
      render :new
    end
  end

  def associate_tag_to_post
    # @tagging = Tagging.new
    # require 'pry' ; binding.pry
    # @tagging.post_id = params[:post_id]
    # @tagging.tag_id = @tag.id
    require 'pry' ; binding.pry
    Tagging.new(tag_id: @tag.id, post_id: params[:post_id])
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
