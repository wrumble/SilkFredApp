require 'sinatra/base'
require 'fileutils'

require_relative 'models/csv_file'
require_relative 'models/csv_file_reader'
require_relative 'models/csv_file_updater'

  class SilkFredApp < Sinatra::Base

    get '/' do
      erb(:index)
    end

    post '/file' do
      name = params[:csv_file][:filename]
      data = params[:csv_file][:tempfile]
      date = Time.now.strftime("%d-%m-%Y_%H:%M")
      FileUtils::mkdir_p "app/public/csv_files/#{date}"
      FileUtils::mkdir_p "app/public/images/#{date}"
      path = "app/public/csv_files/#{date}/#{name}"
      image_path = "app/public/images/#{date}"
      File.open(path, "wb") do |file|
        file.write(data.read)
      end
      @@csv_file = Csv_File.new(name, date, path, image_path)
      CSV_File_Reader.new(@@csv_file)
      redirect '/finished'
    end

    get '/finished' do
      Csv_File_Updater.new(@@csv_file)
      @file = @@csv_file
      erb(:finished)
    end

    run! if app_file == $0
  end
