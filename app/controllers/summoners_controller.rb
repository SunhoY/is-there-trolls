class SummonersController < ApplicationController
  respond_to :json

  def find
    summoner_name = params[:summoner_name]
    region = 'kr'
    summoner_api_version = 'v1.4'
    end_point = "https://#{region}.api.pvp.net"

    api_key = '98db35c2-481e-4105-be18-a1e34a7cf1a7'

    url = URI::encode("#{end_point}/api/lol/#{region}/#{summoner_api_version}/summoner/by-name/#{summoner_name}?api_key=#{api_key}")
    uri = URI(url)

    Net::HTTP.start(uri.host, :use_ssl => true) do |http|
      request = Net::HTTP::Get.new uri.request_uri
      response = http.request request

      puts response
    end

    render nothing: true, :status => :ok
  end
end