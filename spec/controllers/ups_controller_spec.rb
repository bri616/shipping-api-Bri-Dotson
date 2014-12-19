require 'rails_helper'

RSpec.describe UpsController, :type => :controller do
  describe "rates" do
    it 'returns a json object with shipping rates' do
      get :rates,
        :package_specs => {
          :weights => ["100"],
          :dimensions => [["20","20","20"]]
          },

        :origin_specs => {
          :country => 'US',
          :state => 'CA',
          :city => 'Beverly Hills',
          :zip => '90210'
          },

        :destination_specs => {
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
