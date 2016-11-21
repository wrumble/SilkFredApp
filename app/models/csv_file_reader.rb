require 'csv'
require_relative 'montage'

class CSV_File_Reader

  def initialize file
    @file = file
    match_image_urls
  end

  def match_image_urls
    urls = [[],[]]
    CSV.foreach(@file.path) do |row|
      urls[0] << row[0]
      urls[1] << row[1]
    end
    extract_urls urls
  end

  def extract_urls urls
    urls = urls.transpose
    count = 0
    urls.each do |matched|
      break if matched[0] == nil
      Montage.new(matched, count, @file)
      count += 1
    end
  end
end
