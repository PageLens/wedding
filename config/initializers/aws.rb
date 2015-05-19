AWS_CRENDENTIALS = Aws::Credentials.new(Rails.application.secrets.aws_access_key, Rails.application.secrets.aws_secret_access_key)

Aws.config.update({
  region: 'us-west-2',
  credentials: AWS_CRENDENTIALS
})
