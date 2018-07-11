class Ticket < ApplicationRecord
  belongs_to :place
  has_many :order_lines
  has_many :orders, through: :order_lines

  validates :name, presence: true
  validates_uniqueness_of :name, :scope => :place_id
end
