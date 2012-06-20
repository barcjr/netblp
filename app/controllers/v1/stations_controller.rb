class V1::StationsController < ApplicationController
  respond_to :json

  before_filter{ @book = Book.find(params[:book_id]) }

  def index
    @dupes = @book.contacts.where(band: params[:band], mode: params[:mode]).reorder(:callsign).uniq.pluck(:callsign).to_set
    @stations = @book.contacts.select([:callsign, :category, :section]).where("callsign LIKE ?", "#{params[:partial]}%").reorder(:callsign).limit(params[:limit]).uniq.map do |station|

      {callsign: station.callsign, category: station.category, section: station.section, dupe: @dupes.include?(station.callsign)}
    end
    render json: {stations: @stations}
  end

  def show
    @station = @book.contacts.where(callsign: params[:id]).select([:callsign, :category, :section]).first!
    render json: {
      callsign: @station.callsign,
      category: @station.category,
      section: @station.section,
      dupe: @book.contacts.where(callsign: params[:id], band: params[:band], mode: params[:mode]).exists?
    }
  end
end
