require 'test_helper'

class CarpoolsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @carpool = carpools(:one)
  end

  test "should get index" do
    get carpools_url
    assert_response :success
  end

  test "should get new" do
    get new_carpool_url
    assert_response :success
  end

  test "should create carpool" do
    assert_difference('Carpool.count') do
      post carpools_url, params: { carpool: { beginning_campus_id: @carpool.beginning_campus_id, ending_campus_id: @carpool.ending_campus_id } }
    end

    assert_redirected_to carpool_url(Carpool.last)
  end

  test "should show carpool" do
    get carpool_url(@carpool)
    assert_response :success
  end

  test "should get edit" do
    get edit_carpool_url(@carpool)
    assert_response :success
  end

  test "should update carpool" do
    patch carpool_url(@carpool), params: { carpool: { beginning_campus_id: @carpool.beginning_campus_id, ending_campus_id: @carpool.ending_campus_id } }
    assert_redirected_to carpool_url(@carpool)
  end

  test "should destroy carpool" do
    assert_difference('Carpool.count', -1) do
      delete carpool_url(@carpool)
    end

    assert_redirected_to carpools_url
  end
end
