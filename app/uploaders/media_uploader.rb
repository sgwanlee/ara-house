# encoding: utf-8

class MediaUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::Video

  def auto_orient
    manipulate! do |image|
      image.tap(&:auto_orient)
    end
  end

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

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  IMAGE_EXTENSIONS = %w(jpg jpeg gif png)
  VIDEO_EXTENSIONS = %w(mp4 mov)
  def extension_white_list
    IMAGE_EXTENSIONS + VIDEO_EXTENSIONS
  end



  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  # create a new "process_extensions" method.  It is like "process", except
  # it takes an array of extensions as the first parameter, and registers
  # a trampoline method which checks the extension before invocation
  def self.process_extensions(*args)
    extensions = args.shift
    args.each do |arg|
      if arg.is_a?(Hash)
        arg.each do |method, args|
          processors.push([:process_trampoline, [extensions, method, args]])
        end
      else
        processors.push([:process_trampoline, [extensions, arg, []]])
      end
    end
  end

  # our trampoline method which only performs processing if the extension matches
  def process_trampoline(extensions, method, args)
    extension = File.extname(original_filename).downcase
    extension = extension[1..-1] if extension[0,1] == '.'
    self.send(method, *args) if extensions.include?(extension)
  end

  def filename
    if original_filename
      if IMAGE_EXTENSIONS.any? {|img_f| original_filename.downcase.include?(img_f)}
        result = original_filename
      else
        result = [original_filename.gsub(/.\w+$/, ""), 'mp4'].join('.')
      end
    else
      result = nil
    end
    result
  end

  process_extensions IMAGE_EXTENSIONS, :resize_to_limit => [400, 400]
  process_extensions IMAGE_EXTENSIONS, :auto_orient
  process_extensions VIDEO_EXTENSIONS, encode_video: [:mp4, audio_codec: "aac", resolution: "400x400", preserve_aspect_ratio: :height ]

end