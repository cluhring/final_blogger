require 'test_helper'

class CommentIntegrationTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  attr_reader :post1, :post2

  def setup
    @post1 = Post.create(title: "My Published Post",
                        author: "grumpy",
                        body: "His body",
                        status: true,
                        id: 505 )
    @post2 = Post.create(title: "My Draft Post",
                        author: "grumpy",
                        body: "Her body",
                        status: false,
                        id: 78 )
    @comment1 = Comment.create(author: "Sir Mix Alot",
                              body: "## An h2 header ##",
                              post_id: post1.id)
    @comment2 = Comment.create(author: "Miss Mix Alot",
                              body: "## An h2 header ##",
                              post_id: post2.id)
  end

  test "A user can see and add comments to a post" do
    visit "/"
    click_link_or_button('My Published Post')
    assert_equal "/posts/505", current_path
    within ('.comments') do
      assert page.has_content?('Sir Mix Alot')
    end
    within ('.my_new_comment') do
      assert page.has_content?('Add a Comment to the My Published Post Post')
    end
  end

  test "A user can add a comment to a post" do
    assert_equal 2, Comment.count
    visit "/"
    click_link_or_button('My Published Post')
    fill_in "comment[body]", with: "Peas and Carrots"
    fill_in "comment[author]", with: "Jack"
    click_link_or_button('submit')
    assert_equal 3, Comment.count
    assert page.has_content?('Peas and Carrots')
    assert page.has_content?('Comment by Jack:')
    assert page.has_content?('Thanks for successfully adding your comment, Jack.')
    save_and_open_page
  end

  test "A user can delete a post and the associated comments with one click" do
    assert_equal 2, Comment.count
    visit "/"
    click_link_or_button('Delete')
    assert_equal 1, Comment.count
  end

  test "A comment's body is rendered in HTML if markdown is entered" do
    visit "/"
    click_link_or_button('My Published Post')
    refute page.has_content?("## An h2 header ##")
    within ("h2") do
      assert page.has_content?("An h2 header")
    end
  end
end
