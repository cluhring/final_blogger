require 'test_helper'

class TaggingTest < ActiveSupport::TestCase
  attr_reader :tagging1,
              :tagging2

  def setup
    Tag.create(name: "Sick Post Bro", id: 661)
    Tag.create(name: "Sweet Post Bro", id: 662)
    Post.create(title:"Wan",
                body: "Twas the best of times",
                author: "Chris Luhring",
                status: false,
                id: 498)
    @tagging1 = Tagging.create(tag_id: 661, post_id: 498)
    @tagging2 = Tagging.create(tag_id: 662, post_id: 498)
  end

  def test_tagging_is_valid
    assert tagging1.valid?
  end

  def test_tagging_belongs_to_a_tag
    assert_equal "Sick Post Bro", tagging1.tag.name
    assert_equal "Sweet Post Bro", tagging2.tag.name
  end

  def test_tagging_belongs_to_a_post
    assert_equal "Wan", tagging1.post.title
    assert_equal "Wan", tagging2.post.title
  end
end
