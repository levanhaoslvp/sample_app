require "zip"
class ExportController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    compressed_files = export_files
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

  def export_files
    list = list_output
    Zip::OutputStream.write_buffer(::StringIO.new) do |out|
      list.each do |member|
        out.put_next_entry("user_#{member[:name]}.csv")
        csv = export_csv(member[:object], member[:hearder_csv])
        out.print csv
      end
    end
  end

  def export_csv object, header
    ExportCsvService.new(object, header).perform
  end

  def list_output
    [
      {
        name: "post",
        object: @user.posts.a_month_ago,
        hearder_csv: %w(created_at content).freeze
      },
      {
        name: "follower",
        object: User.follower_a_month_ago(@user),
        hearder_csv: %w(name created_at).freeze
      },
      {
        name: "following",
        object: User.following_a_month_ago(@user),
        hearder_csv: %w(name created_at).freeze
      }
    ]
  end
end
