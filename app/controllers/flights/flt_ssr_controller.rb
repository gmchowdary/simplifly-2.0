class Flights::FltSsrController < ApplicationController
  def flt_index
    puts params.to_json.inspect
  end
  def add_services
    @flight = []
    par_trip_type_arr = params['complete_booking'].keys

    if par_trip_type_arr.include? "ow"
      trip_type = "ow"
      trip_par = params["complete_booking"]["ow"]
      trip_par_os = convert_json_to_os_obj trip_par
      trp_onward_segs = trip_par_os.flights_price_rs.onward_sector.flt[0].segs.seg
      trp_fares =  trip_par_os.flights_price_rs.fares.fare
      puts trp_fares
      @selected_flt_booking_obj = trip_par
      @flight = { "ow" => trp_onward_segs }
      @fare = trp_fares
    elsif par_trip_type_arr.include? "rt"
      trip_type = "rt"
      trip_par = params["complete_booking"]["rt"]
      trip_par_os = convert_json_to_os_obj trip_par
      trp_onward_segs = trip_par_os.flights_price_rs.onward_sector.flt[0].segs.seg
      trp_return_segs = trip_par_os.flights_price_rs.return_sector.flt[0].segs.seg
      trp_fares =  trip_par_os.flights_price_rs.fares.fare
      @selected_flt_booking_obj = trip_par
      @flight = {"rto" => trp_onward_segs, "rtr" => trp_return_segs }
      @fare = trp_fares
    end
    ssr_avai_json_response = ""
    session["demo_run"] = params["demo_run"].nil? ? false : true
    if session["demo_run"] or is_demo_run
      ssr_avai_json_response = sample_ssr_response_json_ow()
    else
      json_response = post_request_get_response('ssr', build_ssr_request_xml())
      write_demo_file_rs_ow(json_response)
      ssr_avai_json_response = json_response
    end
    @ssr_avail_rs_hash_ow = (convert_json_to_hash ssr_avai_json_response)["ssr_price_rs"]["onward_sector"][0]["segs"]["seg"]

  end
  private

  def build_ssr_request_xml()
    
    request = Nokogiri::XML::Builder.new do |xml|
      xml.ssr_price_rq do |root|
        root.call_id "SIM_1234567890"
        root.bkg_ngn_360_api_user do |user|
          user.user_id "otaapi"
          user.password "Goair@@018"
          user.is_pw_encr "no"
        end
        root.pax do |pas_cnt|
          pas_cnt.adt 1
          pas_cnt.chd 0
          pas_cnt.inf 0
        end

        @flight.each{ | sec, sgmt_arr |
          if ["ow","rto"].include? sec
            root.onward_sector do |on_sec|
              on_sec.segs do |segments|
                sgmt_arr.each{ |sgmt|
                  segments.seg do |segment|
                    segment.flt_num sgmt.flt_num
                    segment.dept_datetime sgmt.dept_datetime
                    segment.arr_datetime sgmt.arr_datetime
                    segment.origin sgmt.origin
                    segment.dest sgmt.dest
                    segment.stops sgmt.stops
                    segment.via sgmt.via
                    segment.aircraft sgmt.aircraft
                    segment.dept_term sgmt.dept_term
                    segment.arr_term sgmt.arr_term
                    segment.dur sgmt.dur
                    segment.bag_alw sgmt.bag_alw
                  end
                }
              end
            end
          else
            root.return_sector do |rt_sec|
              rt_sec.segs do |segments|
                sgmt_arr.each{ |sgmt|
                  segments.seg do |segment|
                    segment.flt_num sgmt.flt_num
                    segment.dept_datetime sgmt.dept_datetime
                    segment.arr_datetime sgmt.arr_datetime
                    segment.origin sgmt.origin
                    segment.dest sgmt.dest
                    segment.stops sgmt.stops
                    segment.via sgmt.via
                    segment.aircraft sgmt.aircraft
                    segment.dept_term sgmt.dept_term
                    segment.arr_term sgmt.arr_term
                    segment.dur sgmt.dur
                    segment.bag_alw sgmt.bag_alw
                  end
                }
              end
            end
          end
        }
        root.fares do |fars|
          fars.fare do |far|
            far.vdr_sup_rel_id @fare.vdr_sup_rel_id
            far.base @fare.base
            far.charge_yq @fare.charge_yq
            far.charge_yr @fare.charge_yr
            far.charge_psf @fare.charge_psf
            far.charge_udf @fare.charge_udf
            far.charge_k3 @fare.charge_k3
            far.charge_jn @fare.charge_jn
            far.charge_ot @fare.charge_ot
            far.charge_sbc @fare.charge_sbc
            far.charge_kkc @fare.charge_kkc
            far.charge_xx @fare.charge_xx
            far.charge_sst @fare.charge_sst
            far.cabin_cls @fare.cabin_cls
            far.cabin_cls_name @fare.cabin_cls_name
            far.fb_code @fare.fb_code
            far.fare_cls @fare.fare_cls
            far.seats @fare.seats
          end
        end
      end
    end
    
    request = request.doc.root.to_s
    return request
  end
  
  def sample_ssr_request_xml()
    
  end
  
  def sample_ssr_response_json_ow()
    File.read('xmls/ssr/ssr_ow.json')
  end

  def sample_ssr_response_json_rt()
    File.read('xmls/ssr/ssr_rt.json')
  end  

  def write_demo_file_rs_ow(ssr_json)
    f_obj = File.open('xmls/ssr/ssr_ow.json','w')
    f_obj.write(ssr_json)
    f_obj.close()
  end
  
  def write_demo_file_rs_rt(ssr_json)
    f_obj = File.open('xmls/ssr/ssr_rt.json','w')
    f_obj.write(ssr_json)
    f_obj.close()
  end
end
