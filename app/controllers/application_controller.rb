require 'zlib'
include Zlib
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def is_demo_run()
    false
  end
  
  def post_request_get_response(action,xml_req)
    
    uri = begin_api_uri(action)
    
    puts "++++++++++++++ REQUEST +++++++++++++"
    puts xml_req
    
    uri = URI.parse(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    #http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
    request.body = {"multipart/form-data" => [ xml_req ]}.to_json

    response = http.request(request)

    response = response.body
    
    puts "++++++++++++++ RESPONSE +++++++++++++"
    puts response
    
    return response

  end

  def convert_json_to_os_obj(json_string)
    JSON.parse(json_string, object_class: OpenStruct)
  end
  
  def convert_json_to_hash(json_string)
    JSON.parse(json_string, object_class: Hash)
  end
  
  def compress(obj)   
    compressed_obj = Base64.encode64  Deflate.deflate(obj, BEST_SPEED)
    return compressed_obj
  end
  def decompress(obj)
     decompressed_obj = Zlib::Inflate.inflate (Base64.decode64  (obj))
     return decompressed_obj
  end
  def validate_os_root(os_obj)
    os_obj = os_obj.table unless os_obj.table.nil?
    os_obj
  end
  
  def begin_api_uri(action)
    'http://52.74.59.251:3001/' + (action.to_s)
  end
end
