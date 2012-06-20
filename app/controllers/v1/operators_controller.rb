class V1::OperatorsController < ApplicationController
  respond_to :json

  before_filter{ @book = Book.find(params[:book_id]) }

  def index
    render json: {operators: [{name: "Hargobind K. (AB0YL)"}, {name: "David S. (KC0DDR)"}]}
  end
end
