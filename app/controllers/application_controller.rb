require 'rest_client'

class ApplicationController < ActionController::Base
 def index
  parsed_json = []
 times = []
 cases = []
 location = []
 json_object =  RestClient.get 'https://data.sfgov.org/resource/tmnf-yvry.json?category=sex%20offenses,%20forcible'
  parsed_json << JSON.parse(json_object)
  parsed_json.each do |i|
    cases << i
  end
    cases.each do |casee|
      casee.each do |i|
        times << [i["descript"],i["x"],i["y"]]
      end
    end
   print times
 end
end

