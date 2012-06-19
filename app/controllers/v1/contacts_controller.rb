class V1::ContactsController < ApplicationController
  respond_to :json

  before_filter{ @book = Book.find(params[:book_id]) }

  def index
    @query = Query.new(@book.contacts.search(params), params, limit: 100)
    @contacts = @query.result
    respond_with @contacts
  end

  def show
    @contact = @book.contacts.find(params[:id])
    respond_with @contact
  end

  def create
    @contact = @book.contacts.create(Contact.filter_params(params))
    respond_with @contact
  end

  def update
    @contact = @book.contacts.find(params[:id])
    @contact.update_attributes(Contact.filter_params(params))
    respond_with @contact
  end
end
