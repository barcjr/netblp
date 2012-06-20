class V1::RadiosController < ApplicationController
  respond_to :json

  before_filter{ @book = Book.find(params[:book_id]) }

  def index
    @radios = @book.radios
    respond_with @radios
  end

  def show
    @radio = @book.radios.find(params[:id])
    respond_with @radio
  end

  def create
    @radio = @book.radios.create(Radio.filter_params(params))
    respond_with @radio
  end

  def update
    @radio = @book.radios.find(params[:id])
    @radio.update_attributes Radio.filter_params(params)
    respond_with @radio
  end
end
