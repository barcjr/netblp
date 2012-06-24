class SectionsController < ApplicationController
  respond_to :html

  before_filter { @book = Book.find(params[:book_id]) }

  def index
    @section_counts = @book.contacts.reorder(nil).group(:section).count
    @section_times = Hash[@book.contacts.reorder(nil).group(:section).select("section, MIN(timestamp) AS timestamp").map{ |contact| [contact.section, contact.timestamp] }]
    @sections = Section.all.map do |section|
      {code: section.code, name: section.name, count: @section_counts[section.code], timestamp: @section_times[section.code]}
    end
    respond_with @sections
  end
end

