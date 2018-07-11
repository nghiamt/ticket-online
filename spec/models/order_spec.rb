require 'rails_helper'

describe Order do

  describe '#receiver_name' do
    it {should validate_presence_of(:receiver_name)}
  end
  describe '#receiver_address' do
    it {should validate_presence_of(:receiver_address)}
  end
end
