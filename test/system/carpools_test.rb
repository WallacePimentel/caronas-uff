require "application_system_test_case"

class CarpoolsTest < ApplicationSystemTestCase
  setup do
    @carpool = carpools(:one)
  end

  test "visiting the index" do
    visit carpools_url
    assert_selector "h1", text: "Carpools"
  end

  test "creating a Carpool" do
    visit carpools_url
    click_on "New Carpool"

    fill_in "Begging campus", with: @carpool.begging_campus_id
    fill_in "Ending campus", with: @carpool.ending_campus_id
    click_on "Create Carpool"

    assert_text "Carpool was successfully created"
    click_on "Back"
  end

  test "updating a Carpool" do
    visit carpools_url
    click_on "Edit", match: :first

    fill_in "Begging campus", with: @carpool.begging_campus_id
    fill_in "Ending campus", with: @carpool.ending_campus_id
    click_on "Update Carpool"

    assert_text "Carpool was successfully updated"
    click_on "Back"
  end

  test "destroying a Carpool" do
    visit carpools_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Carpool was successfully destroyed"
  end
end
