require 'rails_helper'

RSpec.describe Campu, type: :model do
  describe 'first validation' do
    it 'is valid with valid attributes' do
      campus = build(:campu)
      expect(campus).to be_valid
    end
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:status).with_values(ativo: 0, inativo: 1) }
  end

  describe 'scopes' do
    describe '.active' do
      it 'returns only active campus' do
        active_campus = create(:campu, status: :ativo)
        inactive_campus = create(:campu, status: :inativo)
        
        expect(Campu.active).to include(active_campus)
        expect(Campu.active).not_to include(inactive_campus)
      end
    end

    describe '.search_by_term' do
      let!(:campus1) { create(:campu, description: 'Campus Central', city: 'São Paulo', district: 'Centro') }
      let!(:campus2) { create(:campu, description: 'Campus Norte', city: 'Rio de Janeiro', district: 'Zona Norte') }
      let!(:campus3) { create(:campu, description: 'Campus Sul', city: 'Curitiba', district: 'Batel') }

      it 'finds campus by description' do
        result = Campu.search_by_term('Central')
        expect(result).to include(campus1)
        expect(result).not_to include(campus2, campus3)
      end

      it 'finds campus by city' do
        result = Campu.search_by_term('Rio de Janeiro')
        expect(result).to include(campus2)
        expect(result).not_to include(campus1, campus3)
      end

      it 'finds campus by district' do
        result = Campu.search_by_term('Batel')
        expect(result).to include(campus3)
        expect(result).not_to include(campus1, campus2)
      end

      it 'is case-insensitive' do
        result = Campu.search_by_term('CENTRAL')
        expect(result).to include(campus1)
      end

      it 'performs partial matches' do
        result = Campu.search_by_term('Nor')
        expect(result).to include(campus2)
      end

      it 'returns all campus when term is blank' do
        result = Campu.search_by_term('')
        expect(result).to include(campus1, campus2, campus3)
      end

      it 'returns all campus when term is nil' do
        result = Campu.search_by_term(nil)
        expect(result).to include(campus1, campus2, campus3)
      end

      it 'strips whitespace from search term' do
        result = Campu.search_by_term('  Central  ')
        expect(result).to include(campus1)
      end
    end
end
