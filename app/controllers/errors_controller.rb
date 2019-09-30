class ErrorsController < ApplicationController
  skip_before_action :require_login

  def forbidden
    respond_to do |format|
      format.html { render status: 403 }
      format.json { render json: { error: 'Forbidden' }, status: 403 }
      # format.html { render template: 'errors/403', layout: 'layouts/application', status: 403 }
    end
  end

  def not_found
    respond_to do |format|
      format.html { render status: 404 }
      format.json { render json: { error: 'Resource not found' }, status: 404 }
    end
  end

  def unacceptable
    respond_to do |format|
      format.html { render status: 422 }
      format.json { render json: { error: 'Params unacceptable' }, status: 422 }
    end
  end

  def internal_error
    respond_to do |format|
      format.html { render status: 500 }
      format.json { render json: { error: 'Internal server error' }, status: 500 }
    end
  end
end
