class Place < ApplicationRecord
  has_many :tickets, dependent: :destroy
end
