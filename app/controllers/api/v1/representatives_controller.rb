class Api::V1::RepresentativesController < ApplicationController
  def index
    reps = GoogleFacade.representatives(params[:user_id])

    render json: RepresentativeSerializer.new(reps)
  end
end