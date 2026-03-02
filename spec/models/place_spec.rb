require 'rails_helper'

RSpec.describe Place, type: :model do
  describe 'first validation' do
    it 'is valid with valid attributes' do
      place = build(:place)
      expect(place).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:carpool) }
  end
end
