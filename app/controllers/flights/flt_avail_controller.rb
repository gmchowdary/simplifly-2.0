class Flights::FltAvailController < ApplicationController

  def flt_index
    @json_response = File.read("xmls/price/price_ow.json")
    data_hash = convert_json_to_os_obj(@json_response)
    @ow_trp_segments = data_hash.flights_price_rs.onward_sector.flt[0]
    @ow_trp_fares = data_hash.flights_price_rs
    v_s_id = CorpVendorService.select("vendor_services.id").joins(:corp_vendor_relation).joins(:vendor_service).where(" rank = 1 and corp_vendor_relations.corporate_id = 3").pluck(:id)
    v_s = VendorService.joins(:service).where("vendor_services.id in (?) and services.id = 1 ", v_s_id )
    session[:vdr_sup_rel_id] = nil
  end
  
  def search_flights()
    
    if is_demo_run()
      @data_hash = convert_json_to_os_obj(sample_avail_response_json_ow)
    else
      json_response = post_request_get_response('avail', build_avail_xml_request)
      write_demo_file_rs_ow( json_response )
      @data_hash = convert_json_to_os_obj( json_response )
    end
    
    @onward_segments =  @data_hash.flights_avail_search_rs.onward_sector    
    @qry_str_hash = params[:search_flight]
    case @qry_str_hash[:trip_type]
    when "ow"
      render flights_flt_avail_ow_flights_path
    when "rt"
      @return_segments = @data_hash.flights_avail_search_rs.return_sector
      render flights_flt_avail_rt_flights_path
    end
    
  end
  
  private
  
  def build_avail_xml_request()
    par = get_search_params()
    
    from = par["from"].split(" ")[-1].delete("()")
    to = par["to"].split(" ")[-1].delete("()")
    onw_doj = par["date_of_journey_onward"]
    ret_doj = par["date_of_journey_return"]
    
#    if par[:trip_type] == "rt"
#      onw_doj = DateTime.strptime(onw_doj, '%Y-%m-%d').to_s
#      ret_doj = DateTime.strptime(ret_doj, '%Y-%m-%d').to_s
#    else
#      onw_doj = DateTime.strptime(onw_doj, '%Y-%m-%d').to_s
#    end
    
    class_type = par["class"]
    trip_type = par["trip_type"]
    
    request = Nokogiri::XML::Builder.new do |xml|
      xml.flights_avail_search_rq do |root|
        root.call_id "SIM_1234567890"
        root.bkg_ngn_360_api_user do |user|
          user.user_id "otaapi"
          user.password "Goair@@018"
          user.is_pw_encr "no"
        end
        root.vdr_sup_rel_ids do |vdr_sup_rel_id|
          vdr_sup_rel_id.vdr_sup_rel_id 1
          vdr_sup_rel_id.vdr_sup_rel_id 2
          vdr_sup_rel_id.vdr_sup_rel_id 4
        end
        root.login_types "ALL"
        root.onward_sector do |on_sec|
          on_sec.origin from
          on_sec.dest to
          on_sec.dept_date onw_doj + " 00:00"
        end
      if trip_type == "rt"
        root.return_sector do |rt_sec|
          rt_sec.origin to
          rt_sec.dest from
          rt_sec.dept_date ret_doj + " 00:00"
        end
      else
        root.return_sector nil
      end
        root.pax do |pas_cnt|
          pas_cnt.adt 1
          pas_cnt.chd 0
          pas_cnt.inf 0
        end
        root.return_with_desc do |r_w_t|
          r_w_t.fare_name true
          r_w_t.aircraft_name true
          r_w_t.airport_name true
          r_w_t.airport_city_name true
          r_w_t.charge_name true
          r_w_t.cabin_cls_name true
        end
      end
    end
    
    request = request.doc.root.to_s
    
    return request
    
  end
  
  def get_search_params()
    params.require(:search_flight).permit(:trip_type,:date_of_journey_return,:date_of_journey_onward,:from,:to)
  end
  
  def sample_avail_request_xml()
    
  end
  
  def sample_avail_response_json_ow()
    File.read('xmls/avail/avail_ow.json')
  end

  def sample_avail_response_json_rt()
    File.read('xmls/avail/avail_rt.json')
  end  

  def write_demo_file_rs_ow(avail_json)
    f_obj = File.open('xmls/avail/avail_ow.json','w')
    f_obj.write(avail_json)
    f_obj.close()
  end
  
  def write_demo_file_rs_rt(avail_json)
    f_obj = File.open('xmls/avail/avail_rt.json','w')
    f_obj.write(avail_json)
    f_obj.close()
  end
end
