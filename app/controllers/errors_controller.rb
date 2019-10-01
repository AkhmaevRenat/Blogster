# frozen_string_literal: true

class ErrorsController < ApplicationController
  skip_before_action :require_login

  def forbidden
    respond_to do |format|
      format.html { render status: :forbidden }
      format.json { render json: { error: 'Forbidden' }, status: :forbidden }
      # format.html { render template: 'errors/403', layout: 'layouts/application', status: 403 }
    end
  end

  def not_found
    respond_to do |format|
      format.html { render status: :not_found }
      format.json { render json: { error: 'Resource not found' }, status: :not_found }
    end
  end

  def unacceptable
    respond_to do |format|
      format.html { render status: :unprocessable_entity }
      format.json { render json: { error: 'Params unacceptable' }, status: :unprocessable_entity }
    end
  end

  def internal_error
    respond_to do |format|
      format.html { render status: :internal_server_error }
      format.json { render json: { error: 'Internal server error' }, status: :internal_server_error }
    end
  end
end
