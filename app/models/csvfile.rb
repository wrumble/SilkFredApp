require_relative '../uploaders/file_uploader'

class CsvFile
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :path, String
  property :date, String

  mount_uploader :file, FileUploader

  has n, :image

end
