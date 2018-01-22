require 'test_helper'

class Flights::FltPriceControllerTest < ActionDispatch::IntegrationTest
  test "should get flt_index" do
    get flights_flt_price_flt_index_url
    assert_response :success
  end

end
