require 'rails_helper'
require 'open-uri'

describe 'summoner api', :type => :request do

  describe 'getting a summoner' do
    let!(:summoner_name) { '\uC2DC\uB8E8\uBC24\uBC14' }
    let!(:request_headers) { {'HTTP_ACCEPT' => 'application/json'} }
    let!(:api_key) { '98db35c2-481e-4105-be18-a1e34a7cf1a7' }
    let!(:region) { 'kr' }
    let!(:end_point) { "https://#{region}.api.pvp.net" }
    let!(:summoner_api_version) {'v1.4'}
    let!(:summoner_api) { "/api/lol/#{region}/#{summoner_api_version}/summoner/by-name/#{summoner_name}"}

    before do
      url = "https://#{region}.api.pvp.net/api/lol/#{region}/#{summoner_api_version}/summoner/by-name/#{summoner_name}"

      stub_request(:get, url + "?api_key=#{api_key}")
      get URI::encode("/summoners/#{summoner_name}")
    end

    it 'calls riot game api to get the summoner' do
      expect(response).to be_success
    end


  end
end