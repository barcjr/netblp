class SectionsController < ApplicationController
  respond_to :html

  before_filter { @book = Book.find(params[:book_id]) }

  def index
    @section_counts = @book.contacts.reorder(nil).group(:section).count
    @section_times = @book.contacts.reorder(nil).select("section, MAX(timestamp) AS timestamp").group(:section)
    @sections = Section.all.map do |section|
      {code: section.code, name: section.name, count: @section_counts[section.code]}
    end
    respond_with @sections
  end
end

