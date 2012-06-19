class Contact < ActiveRecord::Base
  include FilterParams

  BANDS = Band.names
  MODES = ["phone", "cw", "digital"]
  SECTIONS = Section.codes

  default_scope order("timestamp DESC")

  belongs_to :book

  attr_accessible :timestamp, :frequency, :band, :mode
  attr_accessible :callsign, :category, :section

  validates :timestamp,
    presence: true
  validates :band,
    inclusion: BANDS
  validates :mode,
    inclusion: MODES
  validates :callsign,
    format: %r{^[A-Z0-9]+$}
  validates :category,
    format: %r{^\d+[A-F]$}
  validates :section,
    inclusion: SECTIONS

  validate do
    next unless frequency && band
    unless Band.for_frequency(frequency).try(:name) == band
      errors.add(:band, "does not match frequency")
    end
  end

  before_validation do
    self.timestamp ||= DateTime.now
    self.band ||= Band.for_frequency(self.frequency).try(:name)
  end

  def self.search params
    scope = self.where(filter_params(params))
    params.each do |k, v|
      scope = case k.to_sym
      when :partial then scope.where('callsign LIKE ?', "#{v}%")
      when :above   then scope.where('frequency > ?', v.to_f)
      when :below   then scope.where('frequency < ?', v.to_f)
      when :after   then scope.where('timestamp > ?', v.to_datetime)
      when :before  then scope.where('timestamp < ?', v.to_datetime)
      else scope
      end
    end
    scope
  end
end
