require 'rails_helper'

describe User do

  describe '#admin?' do
    it "should return true if user is admin" do
      user = User.create email: "test@example.com", password: "hogehoge", role: "admin"
      expect(user.admin?).to eq(true)
    end
  end
  describe '#pending_order' do
    it "should return pending order" do
      user = User.create email: "test@example.com", password: "hogehoge"
      order = user.orders.create receiver_name: "test", receiver_address: "test", status: "pending"
      expect(user.pending_order.id).to eq(order.id)
    end
  end
end
