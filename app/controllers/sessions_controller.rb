# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    render json: 'da'
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])

      log_in user

      remember(user)
      render json: user
    else
      render json: 'Invalid email/password combination'
    end
  end

  def destroy
    log_out if logged_in?
    head 204
  end
end
