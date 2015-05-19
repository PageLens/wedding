class S3Uploader
  # options - Hash to set up the form.
  #           id: HTML DOM ID of the helper upload form (default: 'fileupload').
  #           bucket: name of the S3 bucket (Required).
  #           input_selector: jQuery selector for the input (Required for creating form).
  #           expiration: Expiration of the upload (default: 10.hours.from_now).
  #           max_file_size: Maximum size of the file upload (default: 500M).
  #           acl: Access control for the S3 file (Optional).
  #
  def initialize(options)
    @options = options.reverse_merge(
      id: "fileupload",
      expiration: 10.hours.from_now,
      max_file_size: 500.megabytes,
      input_selector: "file",
      filename: "${filename}",
      acl: 'public-read'
    )
  end

  def form_options
    {
      id: @options[:id],
      method: "post",
      authenticity_token: false,
      multipart: true,
      enforce_utf8: false,
      data: {
        post: @options[:post],
        input_selector: @options[:input_selector]
      }
    }
  end

  def presigned_post1

    @presigned_post ||= @bucket.presigned_post({
      key: key,
      acl: @options[:acl],
      expires: @options[:expiration],
      content_length: 0..@options[:max_file_size].to_i
    }.compact).where(:utf8).starts_with("") # without the utf8 we will get 403 error from AWS.
  end

  def presigned_post
    @presigned_post ||= Aws::S3::PresignedPost.new(AWS_CRENDENTIALS, 'us-west-2', Wedding::S3_BUCKET, {
      # utf8_starts_with: '',
      key: key,
      content_length_range: 0..@options[:max_file_size].to_i,
      acl:  @options[:acl],
      metadata: {
        # 'original-filename' => '${filename}'
      }
    }.compact)
  end

  def fields
    presigned_post.fields
  end

  def key
    @key ||= "uploads/#{SecureRandom.urlsafe_base64(8)}/#{@options[:filename]}"
  end

  def url
    presigned_post.url.to_s
  end
end
