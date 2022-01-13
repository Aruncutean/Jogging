# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Cookies
  include SessionsHelper

  private

  def logged_in_user
    render json: 'Please log in.', status: 403 unless logged_in?
  end
end
