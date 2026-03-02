require 'rails_helper'

RSpec.feature "Campus", type: :feature do
  it 'visits the campus index page' do
    visit(campus_path)
    expect(page).to have_current_path(campus_path)
  end

  context 'searching for campus' do
    example 'with city' do
    end

    example 'with district' do
    end

    example 'with description' do
    end
  end
end
