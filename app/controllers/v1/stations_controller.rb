class V1::StationsController < ApplicationController
  respond_to :json

  def index
    @dupes = Contact.where(band: params[:band], mode: params[:mode]).reorder(:callsign).uniq.pluck(:callsign).to_set
    @stations = Contact.select([:callsign, :category, :section]).where("callsign LIKE ?", "#{params[:partial]}%").reorder(:callsign).uniq.map do |station|

      {callsign: station.callsign, category: station.category, section: station.section, dupe: @dupes.include?(station.callsign)}
    end
    render json: {stations: @stations}
  end

  def show
    @station = Contact.where(callsign: params[:id]).select([:callsign, :category, :section]).first!
    render json: {
      callsign: @station.callsign,
      category: @station.category,
      section: @station.section,
      dupe: Contact.where(callsign: params[:id], band: params[:band], mode: params[:mode]).exists?
    }
  end
end
