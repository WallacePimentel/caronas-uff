require 'rails_helper'

RSpec.feature "Carpools", type: :feature do
  before do
    @campus_origin = create(:campu, description: 'Campus Origem', city: 'Niterói', status: :ativo)
    @campus_destination = create(:campu, description: 'Campus Destino', city: 'Rio das Ostras', status: :ativo)
  end

  scenario 'visits the carpool index page' do
    visit carpools_path
    expect(page).to have_current_path(carpools_path)
  end

  describe 'creating a carpool' do
    scenario 'user can access the new carpool form and see all required fields' do
      visit new_carpool_path
      
      expect(page).to have_field('carpool_driver')
      expect(page).to have_select('carpool_passengers')
      expect(page).to have_select('carpool_price_per_person')
      expect(page).to have_select('carpool_beginning_campus_id')
      expect(page).to have_select('carpool_ending_campus_id')
      expect(page).to have_select('carpool_departure_time_1i') # ano
      expect(page).to have_field('carpool_observation')
      expect(page).to have_link('Adicionar Parada')
      expect(page).to have_button(type: 'submit')
    end
  end

  describe 'viewing carpools' do
    scenario 'displays all carpools in the index page' do
      carpool1 = create(:carpool, 
        driver: 'Carlos Mendes', 
        beginning_campus: @campus_origin, 
        ending_campus: @campus_destination,
        departure_time: 2.days.from_now
      )
      carpool2 = create(:carpool, 
        driver: 'Fernanda Lima', 
        beginning_campus: @campus_destination, 
        ending_campus: @campus_origin,
        departure_time: 3.days.from_now
      )
      
      visit carpools_path
      
      expect(page).to have_content('Carlos Mendes')
      expect(page).to have_content('Fernanda Lima')
    end

    scenario 'shows carpool details with all information' do
      carpool = create(:carpool, 
        driver: 'Roberto Silva',
        passengers: 3,
        price_per_person: 10.0,
        observation: 'Viagem confortável com ar condicionado',
        beginning_campus: @campus_origin,
        ending_campus: @campus_destination,
        departure_time: 1.week.from_now
      )
      
      visit carpool_path(carpool)
      
      expect(page).to have_content('Roberto Silva')
      expect(page).to have_content('3')
      expect(page).to have_content('10.0')
      expect(page).to have_content('Viagem confortável')
      expect(page).to have_content(@campus_origin.description)
      expect(page).to have_content(@campus_destination.description)
    end

    scenario 'shows carpool with intermediate places' do
      carpool = create(:carpool,
        driver: 'Maria Santos',
        beginning_campus: @campus_origin,
        ending_campus: @campus_destination,
        departure_time: 2.days.from_now
      )
      
      place1 = create(:place, 
        carpool: carpool,
        street: 'Rua das Flores',
        number: 123,
        city: 'São Paulo',
        district: 'Jardim Paulista'
      )
      
      place2 = create(:place,
        carpool: carpool,
        street: 'Avenida Paulista',
        number: 1000,
        city: 'São Paulo',
        district: 'Bela Vista'
      )
      
      visit carpool_path(carpool)
      
      expect(page).to have_content('Rua das Flores')
      expect(page).to have_content('Avenida Paulista')
      expect(page).to have_content('Jardim Paulista')
      expect(page).to have_content('Bela Vista')
    end
  end

  describe 'creating a new carpool', js: true do
    scenario 'user fill in the form and create a carpool with beginning and ending campuses' do
      beginning_campus = create(:campu, description: 'Campus A', city: 'Niterói', status: :ativo)
      ending_campus = create(:campu, description: 'Campus B', city: 'Rio das Ostras', status: :ativo)

      visit new_carpool_path

      driver = Faker::Name.name
      number_of_passengers = rand(1..4)
      price_per_person = rand(0..15).to_f
      observation = Faker::Lorem.sentence(word_count: 3)
      
      fill_in('carpool_driver', with: driver)
      select number_of_passengers, from: 'carpool_passengers'
      select price_per_person.to_s, from: 'carpool_price_per_person'
      
      expect(page).to have_css('#carpool_beginning_campus_id + .select2-container', wait: 5)
      
      # Select2 for beginning campus
      find('#carpool_beginning_campus_id + .select2-container').click
      find('.select2-search__field').set(beginning_campus.description)
      find('.select2-results__option', text: beginning_campus.description).click

      # Select2 for ending campus
      find('#carpool_ending_campus_id + .select2-container').click
      find('.select2-search__field').set(ending_campus.description)
      find('.select2-results__option', text: ending_campus.description).click

      select (Date.today + 5.days).year, from: 'carpool_departure_time_1i'
      fill_in 'carpool_observation', with: observation
      
      click_button 'Criar Carona'
      
      expect(page).to have_content(driver)
      expect(page).to have_content(number_of_passengers)
      expect(page).to have_content(price_per_person)
      expect(page).to have_content(observation)
    end

    scenario 'user creates carpool with beginning campus and a stop' do
      beginning_campus = create(:campu, description: 'Campus A', city: 'Niterói', status: :ativo)
      place = create(:place,
        street: 'Rua das Flores',
        number: 123,
        city: 'São Paulo',
        district: 'Jardim Paulista'
      )

      visit new_carpool_path

      driver = Faker::Name.name
      number_of_passengers = rand(1..4)
      price_per_person = rand(0..15).to_f
      observation = Faker::Lorem.sentence(word_count: 3)
      
      fill_in('carpool_driver', with: driver)
      select number_of_passengers, from: 'carpool_passengers'
      select price_per_person.to_s, from: 'carpool_price_per_person'
      
      expect(page).to have_css('#carpool_beginning_campus_id + .select2-container', wait: 5)
      
      # Select2 for beginning campus
      find('#carpool_beginning_campus_id + .select2-container').click
      find('.select2-search__field').set(beginning_campus.description)
      find('.select2-results__option', text: beginning_campus.description).click

      click_link 'Adicionar Parada'
      
      expect(page).to have_css('.nested-fields', wait: 5)

      # Fill in place fields
      within first('.nested-fields') do
        find('input[id$="_street"]').set(place.street)
        find('input[id$="_number"]').set(place.number)
        find('input[id$="_city"]').set(place.city)
        find('input[id$="_district"]').set(place.district)
      end

      select (Date.today + 5.days).year, from: 'carpool_departure_time_1i'
      fill_in 'carpool_observation', with: observation
      
      click_button 'Criar Carona'
      
      expect(page).to have_content('Detalhes', wait: 10)
      
      expect(page).to have_content(driver)
      expect(page).to have_content(number_of_passengers)
      expect(page).to have_content(price_per_person)
      expect(page).to have_content(observation)
    end
  end
end
