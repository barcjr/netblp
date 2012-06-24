class OperatorsController < ApplicationController
  respond_to :html

  before_filter { @book = Book.find(params[:book_id]) }

  def index
    counts = @book.contacts.group(:primary_operator, :secondary_operator).reorder(nil).count
    @counts = {}
    counts.each do |ops, count|
      ops.uniq.each do |op|
        @counts[op] ||= 0
        @counts[op] += count
      end
    end
    respond_with @counts
  end
end

