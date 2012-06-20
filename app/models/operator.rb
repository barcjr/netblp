class Operator < ActiveRecord::Base
  belongs_to :book

  default_scope order(:name)

  attr_accessible :name

  validates :book, presence: true
  validates :name, presence: true, uniqueness: {scope: :book_id}
end
