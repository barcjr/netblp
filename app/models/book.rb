class Book < ActiveRecord::Base
  include FilterParams

  has_many :contacts, dependent: :destroy
  has_many :operators, dependent: :destroy
  has_many :radios, dependent: :destroy

  attr_accessible :title

  validates :title, presence: true, uniqueness: true
end
