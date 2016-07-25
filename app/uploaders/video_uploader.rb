# encoding: utf-8

class VideoUploader < CarrierWave::Uploader::Base
  include CarrierWave::Video

  # process encode_video: [:mp4, callbacks: { after_transcode: :set_success } ]

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(mp4)
  end

end