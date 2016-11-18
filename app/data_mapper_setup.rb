require 'data_mapper'
require 'dm-postgres-adapter'
require 'mini_magick'
require 'carrierwave/datamapper'
require 'carrierwave'

require_relative 'models/image'
require_relative 'models/csvfile'
require_relative 'uploaders/file_uploader'
require_relative 'uploaders/image_uploader'

DataMapper.setup(:default, ENV["DATABASE_URL"] || "postgres://localhost/silkfredapp_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
