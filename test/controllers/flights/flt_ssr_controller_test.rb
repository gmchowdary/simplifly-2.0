require 'test_helper'

class Flights::FltSsrControllerTest < ActionDispatch::IntegrationTest
  test "should get flt_index" do
    get flights_flt_ssr_flt_index_url
    assert_response :success
  end

end
