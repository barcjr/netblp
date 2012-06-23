class BandLimit
  attr_reader :band, :mode, :lower, :upper

  def self.all
    @all ||= load_csv
  end

  def initialize values
    values.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  protected

  def band= name
    @name = name.to_s
  end

  def mode= mode
    @mode = mode.to_s
  end

  def lower= lower
    @lower = lower.to_f
  end

  def upper= upper
    @upper = upper.to_f
  end

  def self.load_csv
    require "csv"

    path = File.join(Rails.root, "data/bandlimits.csv")
    options = {headers: true, header_converters: [:symbol]}

    CSV.read(path, options).map{ |row| self.new row }
  end
end


