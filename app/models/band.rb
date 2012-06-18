class Band
  attr_reader :name, :lower, :upper

  def self.all
    @all ||= load_csv
  end

  def self.names
    all.map(&:name)
  end

  def self.for_frequency frequency
    all.find{ |band| band.lower <= frequency && band.upper >= frequency }
  end

  def initialize values
    values.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  protected

  def name= name
    @name = name.to_s
  end

  def lower= lower
    @lower = lower.to_f
  end

  def upper= upper
    @upper = upper.to_f
  end

  def self.load_csv
    require "csv"

    path = File.join(Rails.root, "data/bands.csv")
    options = {headers: true, header_converters: [:symbol]}

    CSV.read(path, options).map{ |row| self.new row }
  end
end

