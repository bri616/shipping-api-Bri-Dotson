require 'rails_helper'

RSpec.describe UpsController, :type => :controller do
  describe "rates" do
    it 'returns a json object with shipping rates in cents' do
      get :rates,:params => {
        :weight => "100",
        :country_o => 'US',
        :state_o => 'CA',
        :city_o => 'Beverly Hills',
        :zip_o => '90210',
        :country => 'CA',
        :province => 'ON',
        :city => 'Ottawa',
        :postal_code => 'K1P 1J1'
      }

      puts response.inspect

    end
  end
end
