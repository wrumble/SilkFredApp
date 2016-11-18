require 'rmagick'

class Montage

  def initialize urls, count, csv_file
    @csv_file = csv_file
    @urls = urls
    @count = count
    create_list
  end

  def create_list
    @image_list = Magick::ImageList.new(@urls[0], @urls[1])
    create_montage
  end

  def create_montage
    @path = "app/public/images/montage-#{@count}.jpeg"
    @image_list.append(false).write(@path)
    add_logo
  end

  def add_logo
    background = Magick::ImageList.new(@path)
    logo = Magick::ImageList.new("app/public/images/watermark.png")
    logo = logo.resize_to_fit(540,400)
    logo_image = Magick::ImageList.new()
    logo_image = background.composite(logo, Magick::SouthEastGravity, 40, 40, Magick::OverCompositeOp)
    logo_image.write(@path)
    save_image
  end

  def save_image
    File.open(@path, "wb") do |file|
      @csv_file.image.create(path: @path,
                             image: file)
    end
  end

end
