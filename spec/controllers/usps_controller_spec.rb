require 'rails_helper'

RSpec.describe UspsController, :type => :controller do
  it 'returns a json object with shipping rates' do
    get :rates,
    :package_specs => {
      :weights => ["200"]
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

    expect(JSON.parse(response.body.to_s)["USPS First-Class Mail Parcel"]).to be > 0

  end
end
