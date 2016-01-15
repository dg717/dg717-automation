class AvatarUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  def default_url(*args)
    "image-placeholder.jpg"
  end
  
  version :standard do
    process :resize_to_fill => [500, 500, :north]
  end
    
end