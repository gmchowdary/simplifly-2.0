class Flights::FltTicketController < ApplicationController
  def flt_index
  end
  
  def show_summary
    @selected_flt_booking_obj = params["selected_flights"]
    @flight = {}
    if params["trip_type"] == "ow"
      @trip_type = "ow"
      trip_os = convert_json_to_os_obj(params["selected_flights"])
      @segments = trip_os.flights_price_rs.onward_sector.flt[0].segs.seg
      @fare = trip_os.flights_price_rs.fares.fare
      @flight = { "ow" => @segments }
    elsif params["trip_type"] == "rt"
      @trip_type = "rt"
      trip_json = params["selected_flights"]
      trip_os = convert_json_to_os_obj(trip_json)
      @trp_onward_segs = trip_os.flights_price_rs.onward_sector.flt[0].segs.seg
      @trp_return_segs = trip_os.flights_price_rs.return_sector.flt[0].segs.seg
      @flight = {"rto" => @trp_onward_segs,  "rtr" => @trp_return_segs }
      @fare = trip_os.flights_price_rs.fares.fare
    end
    @added_services = params["add_services"]["approver"]
    @response = sample_ticket_response_json_ow()
    @response = convert_json_to_os_obj(@response).flights_ticket_rs.pax_details.pax[0]
  end
    
  def do_ticket
    @selected_flt_booking_obj = params["selected_flights"]
    @flight = {}
    if params["trip_type"] == "ow"
      @trip_type = "ow"
      trip_os = convert_json_to_os_obj(params["selected_flights"])
      @segments = trip_os.flights_price_rs.onward_sector.flt[0].segs.seg
      @fare = trip_os.flights_price_rs.fares.fare
      @flight = { "ow" => @segments }
    elsif params["trip_type"] == "rt"
      @trip_type = "rt"
      trip_json = params["selected_flights"]
      trip_os = convert_json_to_os_obj(trip_json)
      @trp_onward_segs = trip_os.flights_price_rs.onward_sector.flt[0].segs.seg
      @trp_return_segs = trip_os.flights_price_rs.return_sector.flt[0].segs.seg
      @flight = {"rto" => @trp_onward_segs,  "rtr" => @trp_return_segs }
      @fare = trip_os.flights_price_rs.fares.fare
    end
    
    if session["demo_run"] or is_demo_run()
      @response = sample_ticket_response_json_ow()
    else
      json_response = post_request_get_response('ticket', build_ticket_xml_request)
      write_demo_file_rs_ow(json_response)
      @response = json_response
    end
    
    @response = convert_json_to_os_obj(@response).flights_ticket_rs.pax_details.pax[0]
    render "success"
    #redirect_to flights_flt_ticket_success_path()
  end
  
  private
  
  def build_ticket_xml_request
    
    request = Nokogiri::XML::Builder.new do |xml|
      xml.flights_ticket_rq do |root|
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
        root.pax_details do |p_d|
          p_d.pax do |px|
            px.pax_type "ADT"
            px.first_name "Venkat"
            px.middle_name "Rao"
            px.last_name "M"
            px.dob "1988-12-20 00:00"
            px.phone_number "1234567890"
            px.email "venkateswara.rao@irissbsp.com"
            px.gender "M"
            px.title "MR"
          end
        end
        
        root.ticket_action "hold/ticket"
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
#        root.ssrs do |srs|
#          srs.ssr do |sr|
#            sr.seg_key "G8 532~2017-11-25T06:25:00~AMD_CCU"
#            sr.code "XC05"
#            sr.charge 500.0
#          end
#          srs.ssr do |sr|
#            sr.seg_key "G8 537~2017-11-30T16:45:00~CCU_AMD"
#            sr.code "XC10"
#            sr.charge 2000.0
#          end
#        end
      end
    end
    
    request = request.doc.root.to_s
    return request
  end
  
  def sample_ticket_request_xml()
    
  end
  
  def sample_ticket_response_json_ow()
    File.read('xmls/ticket/ticket_ow.json')
  end

  def sample_ticket_response_json_rt()
    File.read('xmls/ticket/ticket_rt.json')
  end  

  def write_demo_file_rs_ow(ticket_json)
    f_obj = File.open('xmls/ticket/ticket_ow.json','w')
    f_obj.write(ticket_json)
    f_obj.close()
  end
  
  def write_demo_file_rs_rt(ticket_json)
    f_obj = File.open('xmls/ticket/ticket_rt.json','w')
    f_obj.write(ticket_json)
    f_obj.close()
  end
end