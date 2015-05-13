require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  def setup
    @post = Post.create(title:"For Testing Only",
                       body: "My Body",
                       author: "Sir Mix Alot",
                       status: false)
  end

  test "comments #create" do
    comment_params = {author: 'Mr. Bear',
                      body: 'Stuff about Fish and Bears'}
    assert_difference('Comment.count') do
      post :create, comment: comment_params, post_id: @post
    end
  end
end
