class ContactsController < ApplicationController
  respond_to :html

  before_filter { @book = Book.find(params[:book_id]) }

  def index
    @count = @book.contacts.count
    @contacts = @book.contacts.page(params[:page])
    respond_with @contacts
  end
end
