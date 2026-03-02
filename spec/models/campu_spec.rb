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
end
