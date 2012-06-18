class Section
  attr_reader :code, :name

  def self.all
    @all ||= load_csv
  end

  def initialize values
    values.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  protected

  attr_writer :code, :name

  def self.load_csv
    require "csv"

    path = File.join(Rails.root, "data/sections.csv")
    options = {headers: true, header_converters: [:symbol]}

    CSV.read(path, options).map{ |row| self.new row }
  end
end
