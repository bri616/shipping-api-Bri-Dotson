class UpsController < ApplicationController
  def rates
    if params[:weight].blank?
      render json: {error: "Must provide a query"}, status: :bad_request
    else

    end
  end
end
