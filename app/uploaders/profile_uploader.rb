class ProfileUploader < PictureUploader
  process resize_to_limit: [50, 50]
  def default_url(*args)
    [version_name, "default.jpg"].compact.join('_')
  end
end