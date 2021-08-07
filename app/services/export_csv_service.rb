require "csv"
class ExportCsvService
  def initialize object, attribute
    @attributes = attribute
    @objects = object
    @header = attribute
  end

  def perform
    CSV.generate do |csv|
      csv << header
      objects.each do |object|
        csv << attributes.map{|attribute| object.public_send(attribute)}
      end
    end
  end

  private
  attr_reader :attributes, :objects, :header
end
