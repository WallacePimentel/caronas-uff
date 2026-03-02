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

    escribe '.limited' do
      let!(:campuses) { create_list(:campu, 5) }

      it 'limits results to specified number' do
        ids = campuses.map(&:id)
        result = Campu.where(id: ids).limited(3)
        expect(result.count).to eq(3)
      end

      it 'returns all when limit is 0' do
        ids = campuses.map(&:id)
        result = Campu.where(id: ids).limited(0)
        expect(result.count).to eq(5)
      end

      it 'returns all when limit is negative' do
        ids = campuses.map(&:id)
        result = Campu.where(id: ids).limited(-1)
        expect(result.count).to eq(5)
      end

      it 'returns all when limit is nil' do
        ids = campuses.map(&:id)
        result = Campu.where(id: ids).limited(nil)
        expect(result.count).to eq(5)
      end
    end

    describe '.for_select2' do
      let!(:active1) { create(:campu, status: :ativo, description: 'Alpha Campus', city: 'São Paulo') }
      let!(:active2) { create(:campu, status: :ativo, description: 'Beta Campus', city: 'Rio') }
      let!(:inactive) { create(:campu, status: :inativo, description: 'Gamma Campus') }

      it 'returns only active campus ordered by description' do
        ids = [active1.id, active2.id, inactive.id]
        result = Campu.where(id: ids).for_select2.to_a
        expect(result).to eq([active1, active2])
      end

      it 'filters by query term' do
        ids = [active1.id, active2.id, inactive.id]
        result = Campu.where(id: ids).for_select2(query: 'Beta')
        expect(result).to include(active2)
        expect(result).not_to include(active1)
      end

      it 'applies limit when provided' do
        ids = [active1.id, active2.id]
        result = Campu.where(id: ids).for_select2(limit: 1)
        expect(result.count).to eq(1)
      end

      it 'combines query and limit' do
        sp1 = create(:campu, status: :ativo, description: 'São Paulo Campus 1')
        sp2 = create(:campu, status: :ativo, description: 'São Paulo Campus 2')
        ids = [sp1.id, sp2.id]
        
        result = Campu.where(id: ids).for_select2(query: 'São Paulo', limit: 1)
        expect(result.count).to eq(1)
        expect(result.first.description).to include('São Paulo')
      end

      it 'excludes inactive campus even with matching query' do
        ids = [active1.id, active2.id, inactive.id]
        result = Campu.where(id: ids).for_select2(query: 'Gamma')
        expect(result).to be_empty
      end
    end
  end
end
