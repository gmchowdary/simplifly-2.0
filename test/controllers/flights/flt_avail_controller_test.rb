require 'test_helper'

class Flights::FltAvailControllerTest < ActionDispatch::IntegrationTest
  test "should get search_flights" do
    get flights_flt_avail_search_flights_url
    assert_response :success
  end

  test "should get index" do
    get flights_flt_avail_index_url
    assert_response :success
  end

  test "should get flights_ow" do
    get flights_flt_avail_flights_ow_url
    assert_response :success
  end

  test "should get flights" do
    get flights_flt_avail_flights_url
    assert_response :success
  end

end
