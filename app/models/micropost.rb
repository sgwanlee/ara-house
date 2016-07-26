class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc)}
  mount_uploader :media, MediaUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :media_size

  def has_image?
    return false if media.url.nil?
    MediaUploader::IMAGE_EXTENSIONS.any? { |img_format| media.url.downcase.include?(img_format)}
  end

  def has_video?
    return false if media.url.nil?
    MediaUploader::VIDEO_EXTENSIONS.any? { |video_format| media.url.downcase.include?(video_format)}
  end

  private
  	def media_size
  		if media.size > 20.megabytes
  			errors.add(:media, "should be less than 5MB")
  		end
  	end



end
