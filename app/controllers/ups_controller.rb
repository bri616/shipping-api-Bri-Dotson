class UpsController < ApplicationController
  def rates
    puts params.inspect

    package_specs = params[:package_specs]
    dims = package_specs[:dimensions].split("x")
    puts dims.inspect
    origin_specs = params[:origin_specs]
    destination_specs = params[:destination_specs]

    if spec_checker(params)
      render json: {error: @message}, status: :bad_request
    else
      puts package_specs[:weights].zip(dims).inspect
      packages = package_specs[:weights].zip(dims).collect{|weight, dimensions| Package.new(weight.to_i, dimensions.collect(&:to_i)) }

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
  when params[:origin_specs].blank?
    @message = "Must provide origin address specifications"
  when params[:destination_specs].blank?
    @message = "Must provide destination address specifications"
  else
    false
  end
end
