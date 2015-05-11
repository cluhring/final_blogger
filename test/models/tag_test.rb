require 'test_helper'

class TagTest < ActiveSupport::TestCase
  attr_reader :tag1,
              :tag2

  def setup
    @tag1 = Tag.create(name: "Sick Post Bro", id: 661)
    @tag2 = Tag.create(name: "Sweet Post Bro", id: 662)
    Post.create(title:"Wan",
                body: "Twas the best of times",
                author: "Chris Luhring",
                status: false,
                id: 498)
    Post.create(title:"The Wan and only",
                body: "Twas ok times",
                author: "Goose",
                status: true,
                id: 499)
    Post.create(title:"The only",
                body: "Twas the worst of times",
                author: "Pete Mitchel",
                status: false,
                id: 500)
    Tagging.create(tag_id: 662, post_id: 498)
    Tagging.create(tag_id: 661, post_id: 498)
    Tagging.create(tag_id: 661, post_id: 499)
  end

  def test_tag_is_valid
    assert tag1.valid?
    assert_equal "Sweet Post Bro", tag2.name
  end

  def test_tags_has_many_posts
    assert_equal 2, tag1.posts.count
    assert_equal 1, tag2.posts.count
    assert_equal "Chris Luhring", tag1.posts.first.author
  end

  def test_tag_responds_to_taggings
    assert_equal 498, tag1.taggings.first.post_id
    assert_equal 499, tag1.taggings.last.post_id
  end

end
