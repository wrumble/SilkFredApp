class CsvFile

  attr_reader :name, :date, :path, :image_path

  def initialize name, date, path, image_path
    @name = name
    @date = date
    @path = path
    @image_path = image_path
  end

end
