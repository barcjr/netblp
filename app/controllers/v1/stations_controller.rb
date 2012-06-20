class V1::StationsController < ApplicationController
  respond_to :json

  def index
    @stations = Contact.select([:callsign, :category, :section]).reorder("").uniq
    render json: {stations: @stations}
  end
end
