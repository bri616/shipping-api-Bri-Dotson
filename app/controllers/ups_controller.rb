class UpsController < ApplicationController
  def rates
    package_specs = params[:package_specs]
    origin_specs = params[:origin_specs]
    destination_specs = params[:destination_specs]

    if spec_checker(params)
      render json: {error: @message}, status: :bad_request
    else
      packages = package_specs[:weights].collect {|weight| Package.new(weight.to_i, nil)}

      origin = Location.new(origin_specs)

      destination = Location.new(destination_specs)

      response = $ups.find_rates(origin, destination, packages)

      ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

      render json: ups_rates.to_h, status: :ok
    end
  end
end

private

def spec_checker(params)
  case
  when params[:package_specs].blank?
    @message = "Must provide package specifications"
  else
    false
  end
end
