class V1::StationsController < ApplicationController
  respond_to :json

  def index
    @dupes = Contact.where(band: params[:band], mode: params[:mode]).reorder(:callsign).uniq.pluck(:callsign).to_set
    @stations = Contact.select([:callsign, :category, :section]).reorder("").uniq.map do |station|
      {callsign: station.callsign, category: station.category, section: station.section, dupe: @dupes.include?(station.callsign)}
    end
    render json: {stations: @stations}
  end
end
