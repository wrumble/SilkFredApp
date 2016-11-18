require_relative '../uploaders/image_uploader'

class Image
  include DataMapper::Resource

  property :id, Serial
  property :path, String

  mount_uploader :image, ImageUploader

  belongs_to :csv_file
end
