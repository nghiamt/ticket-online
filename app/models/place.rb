class Place < ApplicationRecord
  has_many :tickets, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
