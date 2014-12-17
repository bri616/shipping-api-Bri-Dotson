class UpsController < ApplicationController
  def rates
    specs = params[:specs]

    if specs.blank?
      render json: {error: "Must provide specifications"}, status: :bad_request
    else
      package = Package.new(specs[:weight].to_i, nil)

      origin = Location.new(
      :country => specs[:country_o],
      :state => specs[:state_o],
      :city => specs[:city_o],
      :zip => specs[:zip_o])

      destination = Location.new(
      :country => specs[:country],
      :state => specs[:state],
      :city => specs[:city],
      :zip => specs[:zip])

      response = $ups.find_rates(origin, destination, package)

      ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

      render json: ups_rates.to_h, status: :ok
    end
  end
end
