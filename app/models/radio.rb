class Radio < ActiveRecord::Base
  include FilterParams

  belongs_to :book

  attr_accessible :frequency, :name

  validates :book, presence: true
  validates :name, presence: true, uniqueness: {scope: :book_id}

  def band
    Band.for_frequency(frequency).try :name if frequency
  end

  def stale?
    updated_at < Time.now - 1.minute
  end
  alias :stale :stale?
end
