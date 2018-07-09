class Ticket < ApplicationRecord
  belongs_to :place
  has_many :order_lines
  has_many :orders, through: :order_lines
end
