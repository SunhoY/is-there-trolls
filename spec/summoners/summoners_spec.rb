require 'rails_helper'
require 'open-uri'

describe 'summoner api', :type => :request do

  describe 'getting a summoner' do
    let!(:summoner_name) { '시루밤바' } #시루밤바
    let!(:not_existing_summoner_name) { 'not_existing' }
    let!(:request_headers) { {'HTTP_ACCEPT' => 'application/json'} }
    let!(:api_key) { '98db35c2-481e-4105-be18-a1e34a7cf1a7' }
    let!(:region) { 'kr' }
    let!(:end_point) { "https://#{region}.api.pvp.net" }
    let!(:summoner_api_version) {'v1.4'}
    let!(:summoner_api) { "/api/lol/#{region}/#{summoner_api_version}/summoner/by-name/"}
    let!(:mock_json) {
      '{"시루밤바": {"id": 987, "name": "시루밤바", "profileIconId": 999, "summonerLevel": 27, "revisionDate": 1434887550000}}'
    }

    context 'when riot api respond with result' do
      before do
        url = "https://#{region}.api.pvp.net/api/lol/#{region}/#{summoner_api_version}/summoner/by-name/#{summoner_name}"

        stub_request(:get, url + "?api_key=#{api_key}")
            .to_return(:status => 200, :body => mock_json)
        get URI::encode("/summoners/#{summoner_name}")
      end

      it 'calls riot game api to get the summoner' do
        expect(response).to be_success
      end

      it 'gets summoner information' do
        json = JSON.parse(response.body)

        expect(json['id']).to eq(987)
        expect(json['name']).to eq('시루밤바')
        expect(json['summonerLevel']).to eq(27)
        expect(json['profileIconId']).to eq(999)
        expect(json['revisionDate']).to eq(1434887550000)
      end
    end

    context 'when riot api respond with 404' do
      before do
        url = "https://#{region}.api.pvp.net/api/lol/#{region}/#{summoner_api_version}/summoner/by-name/#{not_existing_summoner_name}"

        stub_request(:get, url + "?api_key=#{api_key}")
            .to_return(:status => 404)
        get URI::encode("/summoners/#{not_existing_summoner_name}")
      end

      it 'calls riot game api to get the summoner' do
        expect(response).to be_not_found
      end
    end
  end
end