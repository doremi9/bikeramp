# frozen_string_literal: true

class AvatarUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  version :avatar_m do
    process resize_to_fill: [226, 150]
  end

  version :avatar_s, from_version: :avatar do
    process resize_to_fill: [48, 48]
  end
  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  def store_dir
    "#{env_path}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def size_range
    1..10.megabytes
  end

  def default_url(*args)
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  # def scale(width, height)
  #   # do something
  # end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  private

  def env_path
    env = Rails.env.test? ? "/spec" : ""
    "uploads#{env}"
  end

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
  end
end
