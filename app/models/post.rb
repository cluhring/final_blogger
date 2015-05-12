class Post < ActiveRecord::Base
include PostHelper
  has_many :comments, dependent: :delete_all
  has_many :taggings, dependent: :delete_all
  has_many :tags, through: :taggings

  def draft?
    !status
  end

  def published?
    status
  end
end
