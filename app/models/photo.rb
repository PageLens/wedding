class Photo < ActiveRecord::Base

  before_create :set_url
  after_create :generate_thumbnail

  auto_strip_attributes :title, :creator, :url, :s3_key

  # Resizes image.
  # size - Size (default: '512x512')
  #
  # returns Image.
  #
  def resize(size='512x512')
    if self.url.present?
      image = MiniMagick::Image.open(self.url)
      image.resize(size)
      image
    end
  end

  def generate_thumbnail
    image = self.resize
    if image
      thumb_s3_key = self.s3_key.gsub(/^uploads/, 'thumbnails')
      obj = Aws::S3::Object.new(Wedding::S3_BUCKET, thumb_s3_key)
      obj.upload_file(image.path, acl: 'public-read')
      image.destroy!
      self.update(thumb_s3_key: thumb_s3_key, thumb_url: obj.public_url)
    end
  end

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
