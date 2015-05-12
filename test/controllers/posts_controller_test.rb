require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  def setup
    @post = Post.create(title:"For Testing Only",
                       body: "My Body",
                       author: "Sir Mix Alot",
                       status: false)
  end

  test "posts #index" do
    get :index
    assert_response :success
    assert_routing '/', controller: 'posts', action: 'index'
  end

  test "posts #new" do
    get :new
    assert_response 200
    assert_routing '/posts/new', controller: 'posts', action: 'new'
  end

  test "posts #create" do
    post_params = {title: 'Fish and the Bear',
                   body: 'Stuff about Fish and Bears',
                   author: 'Miss Mix Alot',
                   status: true}
    assert_difference('Post.count') do
      post :create, post: post_params
    end
    assert_redirected_to root_path(assigns(:post))
  end

  test "posts #edit" do
    get :edit, id: @post
    assert_response 200
  end

  test "posts #update" do
    post_params = {title: 'Fish and the Bear',
                   body: 'Stuff about Fish and Bears',
                   author: 'Miss Mix Alot',
                   status: true}
    put :update, id: @post, post: post_params
    assert_redirected_to root_path(assigns(:post))
  end

  test "posts #destroy" do
    assert_difference('Post.count', -1, 'A Post shall be destroyed') do
      delete :destroy, id: @post
    end
    assert_redirected_to root_path
  end

  test "posts #show" do
    get :show, id: @post
    assert_response 200
  end
end
