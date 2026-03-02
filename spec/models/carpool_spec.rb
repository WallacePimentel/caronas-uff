require 'rails_helper'

RSpec.describe Carpool, type: :model do
  describe 'factory' do
    it 'is valid with valid attributes' do
      carpool = build(:carpool)
      expect(carpool).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:beginning_campus).class_name('Campu').optional }
    it { is_expected.to belong_to(:ending_campus).class_name('Campu').optional }
    it { is_expected.to have_many(:places).dependent(:destroy) }
    it { is_expected.to accept_nested_attributes_for(:places).allow_destroy(true) }
  end

  describe 'validations' do
    context 'presence validations' do
      it { is_expected.to validate_presence_of(:driver) }
      it { is_expected.to validate_presence_of(:departure_time) }
      it { is_expected.to validate_presence_of(:price_per_person) }
    end
  end
end