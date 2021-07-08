require "zip"
class ExportController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    compressed_files = zip_files
    respond_to do |format|
      compressed_files.rewind
      format.csv{send_data compressed_files.read, filename: "test.zip"}
      format.html {}
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def csv_files
    list_file = {}
    data = GetDataService.new(@user)
    list_file[:post] = ExportCsvService.new(data.post_a_month,
                                            Post::CSV_ATT).perform
    list_file[:follower] = ExportCsvService.new(data.follower_a_month,
                                                User::CSV_ATT).perform
    list_file[:following] = ExportCsvService.new(data.following_a_month,
                                                 User::CSV_ATT).perform
    list_file
  end

  def zip_files
    Zip::OutputStream.write_buffer(::StringIO.new) do |out|
      csv_files.each do |key, value|
        out.put_next_entry("user_#{key}.csv")
        out.print value
      end
    end
  end
end
