class Flights::FltPriceController < ApplicationController
  def flt_index
  end
  
  def get_flight_price_ow()
    @trip_type = "ow"
    @segment = convert_json_to_os_obj(params["segs"])
    @fare = convert_json_to_os_obj(params["fare"]).table
    json_response = ""
    if is_demo_run()
      json_response = sample_price_response_json_ow()
    else
      json_response = post_request_get_response('price', build_price_request_xml())
      write_demo_file_rs_ow( json_response )
    end
    hash_response = convert_json_to_hash json_response
    @response = convert_json_to_os_obj json_response
    @segment = @response.flights_price_rs.onward_sector.flt[0].segs.seg
    @fare = @response.flights_price_rs.fares.fare
    @response = json_response
    respond_to do |format|               
      format.js
    end      
    
  end
  
  def get_flight_price_rt()
    @trip_type = 'rt'
    @segment = convert_json_to_os_obj(params["rto"]).segs
    @fare = convert_json_to_os_obj(params["rto"]).fare    
    @segmentr = convert_json_to_os_obj(params["rtr"]).segs
    @farer = convert_json_to_os_obj(params["rtr"]).fare
    json_response = post_request_get_response('price', build_price_request_xml())
    hash_response = convert_json_to_hash json_response
    puts "+++++++++++++++++++++++++++++++++++++++"
    puts @response = json_response
    respond_to do |format|               
      format.js
    end
  end
  
  def hold_flight_rt
    @trip_type = params["trip_type"]
    puts "++++++++++++++++++Trip Type+++++++++++++++++++++"
    puts @trip_type
    @segment = convert_json_to_os_obj(params["segs"])
    @fare = convert_json_to_os_obj(params["fare"]).table
    respond_to do |format|               
      format.js
    end    
  end
  
  private

  def build_price_request_xml()
    
    request = Nokogiri::XML::Builder.new do |xml|
      xml.flights_price_rq do |root|
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
        root.onward_sector do |on_sec|
          on_sec.segs do |segments|
            @segment.each{ |sgmt|
              if @trip_type == 'rt'
                sgmt = sgmt.table.table.table
              else
                sgmt = sgmt.table
              end
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
          on_sec.fares do |fars|
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
              far.charge_xxx @fare.charge_xxx
              far.cabin_cls @fare.cabin_cls
              far.cabin_cls_name @fare.cabin_cls_name
              far.fb_code @fare.fb_code
              far.fare_cls @fare.fare_cls
              far.seats @fare.seats
            end
          end
        end
        if @trip_type == 'rt'
          root.return_sector do |rt_sec|
            rt_sec.segs do |segments|
              @segmentr.each{ |sgmt|
                sgmt = sgmt.table.table.table
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
            rt_sec.fares do |fars|
              fars.fare do |far|
                far.vdr_sup_rel_id @farer.vdr_sup_rel_id
                far.base @farer.base
                far.charge_yq @farer.charge_yq
                far.charge_yr @farer.charge_yr
                far.charge_psf @farer.charge_psf
                far.charge_udf @farer.charge_udf
                far.charge_k3 @farer.charge_k3
                far.charge_jn @farer.charge_jn
                far.charge_ot @farer.charge_ot
                far.charge_sbc @farer.charge_sbc
                far.charge_kkc @farer.charge_kkc
                far.charge_xxx @farer.charge_xxx
                far.cabin_cls @farer.cabin_cls
                far.cabin_cls_name @farer.cabin_cls_name
                far.fb_code @farer.fb_code
                far.fare_cls @farer.fare_cls
                far.seats @farer.seats
              end
            end
          end
          
        else
          root.return_sector nil
        end
        
      end
    end
        
    request = request.doc.root.to_s
    
    return request
    
  end
  
  def sample_price_request_xml()
    
  end
  
  
  def sample_price_response_json_ow()
    File.read('xmls/price/price_ow.json')
  end

  def sample_price_response_json_rt()
    File.read('xmls/price/price_rt.json')
  end  

  def write_demo_file_rs_ow(price_json)
    f_obj = File.open('xmls/price/price_ow.json','w')
    f_obj.write(price_json)
    f_obj.close()
  end
  
  def write_demo_file_rs_rt(price_json)
    f_obj = File.open('xmls/price/price_rt.json','w')
    f_obj.write(price_json)
    f_obj.close()
  end
end