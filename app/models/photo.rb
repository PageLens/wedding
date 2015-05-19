class Photo < ActiveRecord::Base

  before_create :set_url

  auto_strip_attributes :title, :creator, :url, :s3_key

private
  def set_url
    self.url ||= url_for_s3_object(self.s3_key)
  end

  def url_for_s3_object(key)
    return nil if key.blank?
    obj = Aws::S3::Object.new(Wedding::S3_BUCKET, key)
    obj.public_url
  end
end
