CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.enable_processing = true
    config.fog_directory = Rails.application.credentials.aws[:bucket] # required
    config.fog_public = false # optional, defaults to true
    config.fog_attributes = { "Cache-Control" => "max-age=315576000" } # optional, defaults to {}

    config.fog_credentials = {
      provider: "AWS", # required
      aws_access_key_id: Rails.application.credentials.aws[:access_key_id], # required
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key], # required
      region: Rails.application.credentials.aws[:region] # optional, defaults to 'us-east-1'
    }
    config.storage = :fog
  else
    config.enable_processing = false
    config.storage = :file
  end
end
