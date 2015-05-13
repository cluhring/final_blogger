require 'test_helper'

class TagsControllerTest < ActionController::TestCase

  def setup
    @post = Post.create(title:"For Testing Only",
                       body: "My Body",
                       author: "Sir Mix Alot",
                       status: false)
  end

  test "tags #new" do
    get :new
    assert_response 200
    assert_routing '/tags/new', controller: 'tags', action: 'new'
  end

  test "tags #create" do
    tag_params = {name: 'Fish and the Bear'}

    assert_difference('Tag.count') do
      post :create, tag: tag_params, post_id: @post
    end
    assert_redirected_to root_path(assigns(:tag))
  end
end
