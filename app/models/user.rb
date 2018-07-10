class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders

  def admin?
    role == "admin"
  end

  def pending_order
    orders.find_or_create_by(status: "pending")
  end
end
