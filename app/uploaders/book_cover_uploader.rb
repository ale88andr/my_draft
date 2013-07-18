# encoding: utf-8

class BookCoverUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "#{Rails.root}/public/uploads/books_cover/#{model.id}"
  end

  process :resize_to_fit => [200, 300]

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end