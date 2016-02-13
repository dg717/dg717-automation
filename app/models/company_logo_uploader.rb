class CompanyLogoUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  def default_url(*args)
    "image-placeholder.jpg"
  end
  
  version :standard do
    process :resize_to_fill => [800, 800, :north]
  end
    
end