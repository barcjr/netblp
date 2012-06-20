class V1::OperatorsController < ApplicationController
  respond_to :json

  before_filter{ @book = Book.find(params[:book_id]) }

  def index
    @operators = @book.operators
    respond_with @operators
  end

  def create
    @operator = @book.operators.create(name: params[:name])
    respond_with @operator
  end
end
