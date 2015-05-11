require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  attr_reader :post, :comment
  def setup
    @post = Post.create(title:"The Wan and only",
                       body: "Twas the best of times, twas not",
                       author: "Chris Luhring",
                       status: false,
                       id: 499)
    @comment = Comment.create(author: "Roy",
                              body: "This is not good.",
                              post_id: post.id)
  end

  def test_comment_is_valid
    assert comment.valid?
    assert_equal "Roy", comment.author
  end

  def test_comment_belongs_to_post
    assert_equal 499, comment.post_id
    assert_equal "The Wan and only", comment.post.title
  end

end
