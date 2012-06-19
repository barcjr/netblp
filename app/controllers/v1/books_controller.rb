class V1::BooksController < ApplicationController
  respond_to :json

  def index
    @query = Query.new(Book, params, limit: 25)
    @books = @query.result
    respond_with @books
  end

  def show
    @book = Book.find(params[:id])
    respond_with @book
  end

  def create
    @book = Book.create(Book.filter_params(params))
    respond_with @book
  end

  def update
    @book = Book.find(params[:id])
    @book.update_attributes(Book.filter_params(params))
    respond_with @book
  end
end
