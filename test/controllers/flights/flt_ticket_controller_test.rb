require 'test_helper'

class Flights::FltTicketControllerTest < ActionDispatch::IntegrationTest
  test "should get flt_index" do
    get flights_flt_ticket_flt_index_url
    assert_response :success
  end

end
