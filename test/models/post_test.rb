require 'test_helper'

class PostTest < ActiveSupport::TestCase
  attr_reader :tagged_and_commented_post,
              :one_tagged_post,
              :untagged_post
  def setup
    @tagged_and_commented_post = Post.create(title:"Wan",
                              body: "Twas the best of times",
                              author: "Chris Luhring",
                              status: false,
                              id: 498)
    @one_tagged_post = Post.create(title:"The Wan and only",
                                  body: "Twas ok times",
                                  author: "Goose",
                                  status: true,
                                  id: 499)
    @untagged_post = Post.create(title:"The only",
                                body: "Twas the worst of times",
                                author: "Pete Mitchell",
                                status: false,
                                id: 500)
    Comment.create(author: "Roy",
                   body: "This is not good.",
                   post_id: tagged_and_commented_post.id)
    Comment.create(author: "Roby",
                   body: "This is good.",
                   post_id: tagged_and_commented_post.id)
    Tag.create(name: "Sick Post Bro", id: 661)
    Tag.create(name: "Sweet Post Bro", id: 662)
    Tagging.create(tag_id: 662, post_id: 498)
    Tagging.create(tag_id: 661, post_id: 498)
    Tagging.create(tag_id: 661, post_id: 499)
  end

  def test_post_is_valid
    assert tagged_and_commented_post.valid?
    assert_equal "The Wan and only", one_tagged_post.title
    assert_equal false, tagged_and_commented_post.status
    assert_equal "Pete Mitchell", untagged_post.author
  end

  def test_post_has_many_tags
    assert_equal 2, tagged_and_commented_post.tags.count
    assert_equal 1, one_tagged_post.tags.count
    assert_equal 0, untagged_post.tags.count

  end

  def test_can_call_tag_methods_on_post_object
    assert_equal "Sick Post Bro", tagged_and_commented_post.tags.first.name
    assert_equal "Sweet Post Bro", tagged_and_commented_post.tags.last.name
  end

  def test_post_has_many_comments
    assert_equal 2, tagged_and_commented_post.comments.count
  end

  def test_can_call_comment_methods_on_post_object
    assert_equal "Roy", tagged_and_commented_post.comments.first.author
    assert_equal "This is good.", tagged_and_commented_post.comments.last.body
  end

  def test_a_post_is_initially_a_draft_and_status_is_false
    post = Post.new(title:"Wan",
                    body: "Twas the best of times",
                    author: "Chris Luhring")
    assert_equal false, post.status
    assert_equal true, post.draft?
    assert_equal false, post.published?
  end

  def test_a_post_is_published_when_status_is_true
    post = Post.new(title:"Wan",
                    body: "Twas the best of times",
                    author: "Chris Luhring",
                    status: true)
    assert_equal true, post.published?
    assert_equal false, post.draft?
  end
end
