require 'rails_helper'

RSpec.feature "Campus", type: :feature do
  before do
    @campus1 = create(:campu, description: 'Campus Gragoatá', city: 'Niterói', district: 'Gragoatá', status: :ativo)
    @campus2 = create(:campu, description: 'Campus Praia Vermelha', city: 'Niterói', district: 'São Domingos', status: :ativo)
    @campus3 = create(:campu, description: 'Campus Rio das Ostras', city: 'Rio das Ostras', district: 'Jardim Bela Vista', status: :ativo)
    @campus_inativo = create(:campu, description: 'Campus Inativo', city: 'Santos', status: :inativo)
  end

  scenario 'visits the campus index page' do
    visit campus_path
    expect(page).to have_current_path(campus_path)
    expect(page).to have_content('Campus')
  end

  context 'viewing campus list' do
    scenario 'displays all active campuses' do
      visit campus_path
      
      expect(page).to have_content('Campus Gragoatá')
      expect(page).to have_content('Campus Praia Vermelha')
      expect(page).to have_content('Campus Rio das Ostras')
    end

    scenario 'shows campus information in the table' do
      visit campus_path
      
      expect(page).to have_content(@campus1.description)
      expect(page).to have_content(@campus1.city)
      expect(page).to have_content(@campus1.district)
      expect(page).to have_content(@campus1.CEP)
    end

    scenario 'inactive campus should not be visible in the list' do
      visit campus_path
      
      expect(page).to have_content(@campus1.description)
      expect(page).to have_content(@campus2.description)
      expect(page).to have_content(@campus3.description)
      expect(page).not_to have_content('Campus Inativo')
    end

    scenario 'has search field for autocomplete' do
      visit campus_path
      
      expect(page).to have_css('select#campus_search')
      expect(page).to have_content('Buscar Campus')
    end
  end

  context 'searching for campus via JSON API' do
    scenario 'returns filtered results by description' do
      visit campus_path(format: :json, q: 'Gragoatá')
      
      json_response = JSON.parse(page.body)
      expect(json_response['results']).to be_a(Array)
      
      campus_ids = json_response['results'].map { |r| r['id'] }
      expect(campus_ids).to include(@campus1.id)
    end

    scenario 'returns filtered results by city' do
      visit campus_path(format: :json, q: 'Rio das Ostras')
      
      json_response = JSON.parse(page.body)
      expect(json_response['results']).to be_a(Array)
      
      campus_ids = json_response['results'].map { |r| r['id'] }
      expect(campus_ids).to include(@campus3.id)
      expect(campus_ids).not_to include(@campus1.id)
    end

    scenario 'returns filtered results by district' do
      visit campus_path(format: :json, q: 'São Domingos')
      
      json_response = JSON.parse(page.body)
      results = json_response['results']
      
      campus_ids = results.map { |r| r['id'] }
      expect(campus_ids).to include(@campus2.id)
    end

    scenario 'returns all active campuses without query' do
      visit campus_path(format: :json)
      
      json_response = JSON.parse(page.body)
      expect(json_response['results']).to be_a(Array)
      expect(json_response['results'].length).to be >= 3
      
      campus_ids = json_response['results'].map { |r| r['id'] }
      expect(campus_ids).not_to include(@campus_inativo.id)
    end

    scenario 'formats results with id and text for select2' do
      visit campus_path(format: :json, q: 'Gragoatá')
      
      json_response = JSON.parse(page.body)
      result = json_response['results'].first
      
      expect(result).to have_key('id')
      expect(result).to have_key('text')
      expect(result['text']).to include('Campus Gragoatá')
      expect(result['text']).to include('Niterói')
    end
  end

  context 'using Select2 search', js:true do
    scenario 'searches for campus, shows in dropdown and filters table' do
      test_campus = create(:campu, 
        description: 'Campus Experimental', 
        city: 'Teste City', 
        district: 'Test District',
        status: :ativo
      )
      
      visit(campus_path)
      
      expect(page).to have_css('.js-campus-search + .select2-container', wait: 5)

      find('.js-campus-search + .select2-container').click
      
      expect(page).to have_css('.select2-search__field', wait: 5)
      
      find('.select2-search__field').set('Campus Experimental')
      
      expect(page).to have_css('.select2-results__option', text: 'Campus Experimental', wait: 5)
      
      find('.select2-results__option', text: 'Campus Experimental').click
      
      expect(page).to have_css("tr[data-campus-id='#{test_campus.id}'].table-warning")
      
      within("tr[data-campus-id='#{test_campus.id}']") do
        expect(page).to have_content('Campus Experimental')
        expect(page).to have_content('Teste City')
        expect(page).to have_content('Test District')
      end
    end
  end
end
