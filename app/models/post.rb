class Post < ActiveRecord::Base
include PostHelper
  has_many :comments, dependent: :delete_all
  has_many :taggings, dependent: :delete_all
  has_many :tags, through: :taggings
  has_attached_file :image,
                    storage: :s3,
                    s3_credentials: Proc.new{|a| a.instance.s3_credentials },
                    styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def s3_credentials
    { bucket: ENV['S3_BUCKET_NAME'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] }
  end

  def draft?
    !status
  end

  def published?
    status
  end
end
