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

  describe 'validates' do
    context 'presence validations' do
      it { is_expected.to validate_presence_of(:driver) }
      it { is_expected.to validate_presence_of(:departure_time) }
      it { is_expected.to validate_presence_of(:price_per_person) }
    end
  
    context 'custom validation: campus_or_stop_present' do
      context 'when both campuses are missing' do
        it 'is invalid without beginning_campus and ending_campus' do
          carpool = build(:carpool, beginning_campus: nil, ending_campus: nil)
          expect(carpool).not_to be_valid
          expect(carpool.errors[:base]).to include(I18n.t('error.carpool.no_campus'))
        end
      end

      context 'when beginning_campus is missing' do
        it 'is invalid without beginning_campus and places' do
          carpool = build(:carpool, beginning_campus: nil, places: [])
          expect(carpool).not_to be_valid
          expect(carpool.errors[:base]).to include(I18n.t('error.carpool.no_stops'))
        end

        it 'is valid with beginning_campus missing but has places' do
          carpool = build(:carpool, beginning_campus: nil)
          carpool.places.build(attributes_for(:place))
          expect(carpool).to be_valid
        end
      end

      context 'when ending_campus is missing' do
        it 'is invalid without ending_campus and places' do
          carpool = build(:carpool, ending_campus: nil, places: [])
          expect(carpool).not_to be_valid
          expect(carpool.errors[:base]).to include(I18n.t('error.carpool.no_stops'))
        end

        it 'is valid with ending_campus missing but has places' do
          carpool = build(:carpool, ending_campus: nil)
          carpool.places.build(attributes_for(:place))
          expect(carpool).to be_valid
        end
      end

      context 'when both campuses are present' do
        it 'is valid even without places' do
          carpool = build(:carpool)
          expect(carpool).to be_valid
        end
      end
    end
  end
end