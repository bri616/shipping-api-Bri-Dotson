require 'rails_helper'

RSpec.describe UpsController, :type => :controller do
  describe "rates" do
    it 'returns a json object with shipping rates' do
      get :rates,:specs => {
        :weight => "100",
        :country_o => 'US',
        :state_o => 'CA',
        :city_o => 'Beverly Hills',
        :zip_o => '90210',
        :country => 'US',
        :state => 'AZ',
        :city => 'Chandler',
        :zip => '85225'
      }

      expect(JSON.parse(response.body.to_s)["UPS Ground"]).to be > 0

    end

    it 'returns an appropriate error if params are empty' do
      get :rates
      expect(response.status).to be 400
    end
  end
end
