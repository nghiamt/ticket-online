class Order < ApplicationRecord
  belongs_to :user
  has_many :order_lines
  has_many :tickets, through: :order_lines

  validates :receiver_name, presence: true
  validates :receiver_address, presence: true
end
