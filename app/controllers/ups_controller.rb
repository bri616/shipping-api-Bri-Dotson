class UpsController < ApplicationController
  def rates

    if params[:params].blank?
      render json: {error: "Must provide a weight"}, status: :bad_request
    else
      package = Package.new(  params[:params][:weight].to_i, nil)

      origin = Location.new(
      :country => params[:params][:country_o],
      :state => params[:params][:state_o],
      :city => params[:params][:city_o],
      :zip => params[:params][:zip_o])

      destination = Location.new(
      :country => params[:params][:country],
      :province => params[:params][:province],
      :city => params[:params][:city],
      :postal_code => params[:params][:postal_code])

      response = $ups.find_rates(origin, destination, package)

      ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

      render json: ups_rates.to_h, status: :ok
    end
  end
end
