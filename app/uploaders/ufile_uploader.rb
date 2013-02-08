# encoding: utf-8
require 'carrierwave/processing/mime_types'

class UfileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  process :set_content_type
  storage :file

  def store_dir
    "#{Rails.root}/files/#{model.user_id}/"
  end
end
