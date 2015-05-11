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
end
