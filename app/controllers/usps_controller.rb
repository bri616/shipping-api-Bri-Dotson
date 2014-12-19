class UspsController < ApplicationController
  def test
    render json: {error: "everything is awesome"}, status: :ok
  end

  def rates
    puts params.inspect
    
    package_specs = params[:package_specs]
    origin_specs = params[:origin_specs]
    destination_specs = params[:destination_specs]
    if spec_checker(params)
      render json: {error: @message}, status: :bad_request
    else
      packages = package_specs[:weights].zip(package_specs[:dimensions]).collect{|weight, dimensions| Package.new(weight.to_i, dimensions.collect(&:to_i)) }

      origin = Location.new(origin_specs)

      destination = Location.new(destination_specs)

      response = $usps.find_rates(origin, destination, packages)

      usps_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

      render json: usps_rates.to_h, status: :ok
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
