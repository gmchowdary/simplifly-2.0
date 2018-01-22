module ApplicationHelper

  
  def get_airline_name(airline_code)
    airlines = {'SG' => "Spice Jet","6E" => "IndiGo", 'AI' => "Air India","9W" => "Jet Airways" }
    return airlines[airline_code]
  end

  def is_preferred_carrier?(airline_code)
    return ['6E'].include? airline_code
  end
  
  def view_airports()
    AirportCode.all.map{ |p| "#{p.municipality} (#{p.iata_code})" }
  end

  def get_airport_name(iata_code)
    AirportCode.select(:name).find_by(iata_code: iata_code ).name
  end

  def get_airport_city(iata_code)
    "#{AirportCode.select(:municipality).find_by(iata_code: iata_code ).municipality}" + " (#{iata_code})"
  end

  def get_stops_str(stops)
    stops == 0 ? "NON STOP" : pluralize(stops, 'Stop')
  end
  def fare_comma_seperator(str)
    str = "0".to_s if str.nil?
    str = str.to_f.round.to_s
    preval = ""
    if str.length >= 3
      above_thousand_str = str[0..-4]
      rev_above_thousand_str = above_thousand_str.reverse
      above_thousand_str_len = (above_thousand_str.length)
      arr = []
      for i in (0..above_thousand_str_len-1).step(2)
        arr <<  rev_above_thousand_str[i..i+1].reverse + ','
      end
      arr.reverse.map{|sub_value| preval = preval + sub_value }
      return preval = preval + str[-3..-1]
    else
      return str
    end
  end
  
  def get_city_code_name(cites_array)
    city_code_name ={}
    cites_array.each do |city|
      city_code_name[city.split("-")[0].strip] =city.split("-")[1].gsub(' ', '')
    end
    city_code_name
  end  
  
  def get_journey(cites_array)
    cites_array[0].split("-")[1].gsub(' ', '') + ' → ' + cites_array[1].split("-")[1].gsub(' ', '')
  end  
  
  def get_fare_class(f_c)
    f_c = f_c.split(":")[0]
    return "Business" if f_c =='D' or f_c =='J' or f_c =='F' or f_c =='P'
    return "Standard" if f_c =='M' or f_c =='L' or f_c =='K' or f_c =='Q' or f_c =='Y' or  f_c =='W' or  f_c =='T' or  f_c =='V'
    return "Corporate" if f_c =='R' or f_c == 'S'
    return "First" if f_c =='F'
    return "Flexi" if f_c =='H'
    return "Sale" if f_c =='P'
    return "Standard"
  end

  def get_cancellation_policy(al)
    if al == "9W"
       return ["<table class='width-100'><thead>Cancel/Change Fee</thead><tr><td>(<)24 hrs</td><td><b>3500 / </b>segment</td></tr><tr><td>24 hrs to 72 hrs</td><td><b>3500 / segment<b></td></tr><tr><td>72 hrs to 7 Days</td><td><b>3500 / segment<b></td></tr><tr><td>(>)7 Days</td><td><b>3500 / segment<b></td></tr></table>"]
    elsif al == "SG" or al == "6E"
      return ["<table class='width-100'><thead>Cancel/Change Fee</thead><tr><td>(>)2 hrs</td><td><b>2,250 / segment</b></td></tr><tr><td>0-2 hrs</td><td><b>No Refund</b></td></tr></table>"]
        
              #,"<table><thead>International</thead><tr><td>(>)4 hours</td><td>2,500/person/segment</td></tr><tr><td>0-4 hours</td><td>No Refund</td></tr></table>"]
    elsif al == "AI"
      return ["<table class='width-100'><thead>Cancel/Change Fee</thead><tr><td>(<)24 hrs</td><td><b>3,500 / segment</b></td></tr><tr><td>24 hrs to 72 hrs</td><td><b>3500 / segment</b></td></tr><tr><td>72 hrs to 7 Days</td><td><b>3500 / segment</b></td></tr><tr><td>(>)7 Days</td><td><b>3500 / segment</b></td></tr></table>"]
    else al == "G8"
      return ["<table class='width-100'><thead>Cancel/Change Fee</thead><tr><td> Flat </td><td><b>2,225</b></td></tr><tr><td> 0-2 hrs </td><td><b>No refund</b></td></tr></table>"]      
    end
  end
  def get_btn_color_class_based(fare_class)
    if ["Corporate","Flexi","Standard"].include? fare_class
      return "color-code-best-suit"
    elsif ["Business"].include? fare_class
      return "color-code-suit"
    elsif ["First","Sale"].include? fare_class
      return "color-code-not-suit"
    else
      return "color-code-suit"
    end
  end
  
  def date_fomatter_d_m_dt_y(date_str)
    Date.parse(date_str).strftime("%a, %b-%d-%Y")
  end
  
  def get_time_from_date_obj(date_str)
    DateTime.parse(date_str).strftime("%H:%M")
  end
  
  def extract_charges_from_fare_obj(fare_obj)
    fare = {}
    fare["Base Fare"] = fare_obj.base.to_f
    fare["Fuel Surcharge"] = fare_obj.charge_yq.to_f
    fare["CUTE Fee"] = fare_obj.charge_yr.to_f
    fare["Passenger Service Fee"] = fare_obj.charge_psf.to_f
    fare["User Development Fee"] = fare_obj.charge_udf.to_f
    fare["charge_ot"] = fare_obj.charge_ot.to_f
    fare["Service Tax"] = fare_obj.charge_jn.to_f
    fare["Swachh Bharat Cess"] = fare_obj.charge_sbc.to_f
    fare["Krishi Kalyan Cess"] = fare_obj.charge_kkc.to_f
    fare["charge_k3"] = fare_obj.charge_k3.to_f
    fare["charge_xx"] = fare_obj.charge_xx.to_f
    fare["charge_xxx"] = fare_obj.charge_xxx.to_f
    fare["charge_sst"] = fare_obj.charge_sst.to_f
    return fare
  end

  def get_total(hash)
    hash.values.sum
  end
  
  def get_airline_code(flt_num_str)
    #flt_num_str.include?("/") ? "*" : 
      flt_num_str.split(" ")[0]
  end
  
  def get_deviation_details(level, fare,is_excepmted, is_preffered )
    violations = {}
    if level.to_i == 2
     violations['cabin_class|non_corporate3'] = "Cabin Class : First selected" if get_fare_class(fare.fare_cls) == 'First' and !is_excepmted

     elsif level.to_i == 3
     violations['cabin_class|non_corporate3'] = "Cabin Class : First selected" if get_fare_class(fare.fare_cls) == 'First' and !is_excepmted

    elsif level.to_i == 6
     violations['cabin_class|non_corporate3'] = "Cabin Class : First selected" if get_fare_class(fare.fare_cls) == 'First'
    # violations['cabin_class|non_corporate1'] = "Fare Class : Non-corporate selected" if get_fare_class(fare.fare_cls) != 'Corporate' and get_fare_class(fare.fare_cls) != 'Business' and get_fare_class(fare.fare_cls) != 'First' and !is_excepmted
     violations['cabin_class|non_corporate2'] = "Cabin Class : Business selected" if get_fare_class(fare.fare_cls) == 'Business'
    # violations['cabin_class|non_corporate3'] = "Cabin Class : First selected" if get_fare_class(fare.fare_cls) == 'First'

    end  
    if level.to_i >2 and !is_excepmted  
     violations['preferred_carrier_policy_deviation'] = "Preferred Carrier : Not selected" unless is_preffered
    end
    

    return violations
  end

  def validate_os_root(os_obj)
    os_obj = os_obj.table unless os_obj.table.nil?
    os_obj
  end
    
  def duration_cal(from_time,to_time)
    puts DateTime.parse(from_time)
    puts DateTime.parse(to_time)
    time_diff = (((DateTime.parse(to_time)- DateTime.parse(from_time))).to_f) * 24
    time_arr = time_diff.to_s.split(".")
    "#{time_arr[0]}h #{((("0." + (time_arr[-1])).to_f)*60).round}m"
  end

end
