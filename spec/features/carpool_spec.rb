require 'rails_helper'

RSpec.feature "Carpools", type: :feature do
  it 'visits the carpool index page' do
    visit(carpools_path)
    expect(page).to have_current_path(carpools_path)
  end

  describe 'creating a carpool' do
    context 'with beginning and ending campuses' do
      visit new_carpool_path
    end

    context 'with beginning campus and stops' do
    end

    context 'with ending campus and stops' do
    end
  end

end
