require 'test_helper'

class TagIntegrationTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  attr_reader :post1, :tag

  def setup
    @post1 = Post.create(title: "My Published Tagged Post",
                        author: "grumpy",
                        body: "His body",
                        status: true,
                        id: 505 )
    Post.create(title: "My Draft Post",
                author: "grumpy",
                body: "Her body",
                status: false,
                id: 78 )
    @tag = Tag.create(name: "Good Stuff",
                      id: 876)
    Tag.create(name: "Bad Stuff")
    Tagging.create(tag_id: tag.id, post_id: post1.id)
  end

  test "A user can see all tags and click a button to add tags to a post" do
    visit "/"
    find_button('Good Stuff')
    find_button('Bad Stuff')
    click_link_or_button('Add tag')
    assert_equal "/tags/new", current_path
    within ('.my_new_tag') do
      assert page.has_content?('Add a Tag')
    end
  end

  test "A user can create a new tag" do
    visit "/"
    click_link_or_button('Add tag')
    fill_in "tag[name]", with: "Jack"
    click_link_or_button('submit')
    assert page.has_button?('Jack')
  end

  test "A user can edit a posts' tags" do
    visit "/"
    refute page.has_content?('Bad Stuff')
    click_link_or_button('Edit')
    assert_equal "/posts/505/edit", current_path
    assert page.has_content?('Good Stuff')
    assert page.has_content?('Bad Stuff')
    find(:css, "#tag_list_tags_bad_stuff[value='Bad Stuff']").set(true)
    click_link_or_button('Submit')
    assert_equal "/", current_path
    assert page.has_content?('Bad Stuff')
  end
end
