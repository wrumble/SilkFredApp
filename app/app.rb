ENV["RACK_ENV"] ||= "development"
require 'sinatra/base'
require_relative 'data_mapper_setup'
require_relative 'models/csv_file_reader'
require_relative 'models/csvfile'

  class SilkFredApp < Sinatra::Base

    get '/' do
      erb(:index)
    end

    post '/file' do
      file_data = params[:csv_file][:tempfile]
      file_name = params[:csv_file][:filename]
      file_path = "app/public/csv_files/#{file_name}"
      File.open(file_path, "wb") do |file|
        file.write(file_data.read)
        @csv_file = CsvFile.create(name: file_name,
                                  path: file_path,
                                  date: Time.now.strftime("%d/%m/%Y %H:%M"),
                                  file: file)
      end
      file = CSV_File_Reader.new(@csv_file)
      erb(:finished)
    end

    run! if app_file == $0
  end
