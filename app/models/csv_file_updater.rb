require 'csv'
require 'fileutils'

class CsvFileUpdater

  def initialize file
    @file = file
    add_urls
  end

  def add_urls
    @count = CSV.read(@file.path).length - 1
    @row_array = []
    i = 0
    CSV.foreach(@file.path, "r+") do |row|
      break if i >= @count
      row << "https://silkfredapp.herokuapp.com/public/images/montage-#{i}.jpeg"
      @row_array << row
      i += 1
    end
    create_new_csv
  end

  def create_new_csv
    CSV.open(@file.path, "w") do |csv|
      @row_array.each { |row| csv << row }
    end
  end

end
