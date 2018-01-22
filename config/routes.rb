Rails.application.routes.draw do
  
  devise_for :users
  namespace :flights do
    get 'flt_price/flt_index'
    get 'flt_price/get_flight_price_ow'
    get 'flt_price/hold_flight_rt'
    get 'flt_price/get_flight_price_rt'
  end

  namespace :flights do
    get 'flt_ticket/flt_index'
    get 'flt_ticket/do_ticket'
    post 'flt_ticket/do_ticket'
    post 'flt_ticket/show_summary'
    get 'flt_ticket/show_summary'
    get 'flt_ticket/success'
  end

  namespace :flights do
    get 'flt_ssr/flt_index'
    get 'flt_ssr/add_services'
  end

  root "flights/flt_avail#flt_index"
  
  namespace :flights do
    get 'flt_avail/search_flights'
    get 'flt_avail/flt_index'
    get 'flt_avail/ow_flights'
    get 'flt_avail/rt_flights'
    get 'flt_avail/rt_flights1'
    get 'flt_avail/available_flights'
    post 'flt_avail/get_airports'
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'bookings/index'
end
