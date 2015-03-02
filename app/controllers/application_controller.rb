require 'rest_client'
require 'json'

class ApplicationController < ActionController::Base
  def index
  json_object =  RestClient.get 'https://data.sfgov.org/resource/tmnf-yvry.json?category=sex%20offenses,%20forcible'
  str = JSON.parse(json_object)
  arr = Array.new
  str.each do |i|
    long = i["y"].to_f
    lat = i["x"].to_f
    arr << [i["descript"],lat,long,i["address"]]
  end
  @geojson = Array.new

  arr.each do |obj|
    @geojson << {
      type: 'Feature',
      geometry: {
        type: 'Point',
        coordinates: [obj[1], obj[2]]
      },
      properties: {
        title: obj[3],
        description: obj[0]
      }
    }
  end
  print "________________________________"
 json =  @geojson.to_json
  f = File.open('output.json', 'w')
  f.write json
  f.close
end
end
