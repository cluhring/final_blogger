class Post < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def draft?
    !status
  end

  def published?
    status
  end

  def published_helper
    if published?
      return "Published"
    elsif draft?
      return "Draft"
    end
  end
end
