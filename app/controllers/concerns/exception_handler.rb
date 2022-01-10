module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { error: e.message }, status: 404
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { error: e.message }, status: 422
    end
  end
end