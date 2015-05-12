require 'test_helper'

class PostIntegrationTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    @post = Post.create(title: "My First Post",
                        author: "grumpy",
                        body: "This is *bongos*, indeed.",
                        status: true,
                        id: 505 )
  end

  test "As an anonymous user, I can see my post on the home page" do
    visit "/"
    assert page.has_content?("All Published Posts")
    assert page.has_content?("My First Post")
    assert page.has_content?("Published")
    assert page.has_content?("Create a New Post")
    assert page.has_content?("See All Posts")
  end

  test "As an anonymous user, I can create a new post" do
    visit "/"
    click_link_or_button("Create a New Post")
    assert_equal "/posts/new", current_path
    fill_in "post[title]", with: "My Second Post"
    fill_in "post[body]", with: "Post Body"
    fill_in "post[author]", with: "Sir Mix Alot"
    fill_in "post[author]", with: "Sir Mix Alot"
    check "post[status]"
    click_link_or_button('Submit')
    assert page.has_content?("My Second Post Post created!")
    assert_equal "My Second Post", Post.first.title
    assert page.has_content?("Sir Mix Alot")
  end

  test "As an anonymous user, I can edit my post" do
    visit "/"
    click_link('Edit')
    assert_equal "/posts/505/edit", current_path
    fill_in "post[title]", with: "My Second Post"
    click_link_or_button('Submit')
    assert_equal "/", current_path
    assert page.has_content?("My Second Post Post updated!")
    assert page.has_content?("My Second Post")
  end

  test "As an anonymous user, I can delete a post" do
    visit "/"
    assert page.has_content?("grumpy")
    click_link('Delete')
    assert page.has_content?("My First Post Post has been deleted.")
    assert_equal "/", current_path
    refute page.has_content?("grumpy")
  end

  test "As an anonymous user, I can see post drafts" do
    post_draft = Post.create(title: "My Second Post",
                        author: "sleepy",
                        status: false,
                        id: 506 )
    visit "/"
    assert page.has_content?("My First Post")
    refute page.has_content?("My Second Post")
    click_link_or_button('See All Posts')
    assert page.has_content?("All Published and Drafted Posts")
    assert page.has_content?("My Second Post")
    assert page.has_content?("Back")
  end

  test "As an anonymous user, I can see a single post show page" do
    visit "/"
    click_link_or_button('My First Post')
    assert_equal "/posts/505", current_path
    within ('h1') do
      assert page.has_content?('My First Post')
    end
  end

  test "A post's body is rendered in HTML if markdown is entered" do
    visit "/"
    click_link_or_button('My First Post')
    refute page.has_content?('This is *bongos*, indeed.')
    within ("em") do
      assert page.has_content?("bongos")
    end
  end
end
