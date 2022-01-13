# frozen_string_literal: true

class UserTimeController < ApplicationController
  before_action :logged_in_user
  before_action :set_userTime, only: %i[destroy update show]
  before_action :normal_user, only: %i[average_time  create showuser destroy update show]
  before_action :admin_user, only: [:index]

  def index
    @userTime = UserTime.all
    render json: @userTime
  end

  def average_time
    user = User.find(params[:id])
    @time = user.user_times.where('date>= ? ', 1.week.ago.utc).average(:time)
    @distance = user.user_times.where('date>= ? ', 1.week.ago.utc).average(:distance)
    @timeTotal = user.user_times.where('date>= ? ', 1.week.ago.utc).sum(:time)
    @distanceTotal = user.user_times.where('date>= ?', 1.week.ago.utc).sum(:distance)

    render json: { time: @time, distance: @distance, timeTotal: @timeTotal, distanceTotal: @distanceTotal }
  end

  def show
    render json: UserTime.find(params[:id])
  end

  def showuser
    render json: UserTime.where(user_id: params[:id])
  end

  def create
    if userTime_params[:user_id].to_s == current_user.id.to_s || admin_user?(@user)

      @userTime = UserTime.new(userTime_params)
      if @userTime.save
        render json: @userTime, status: :created, location: @userTime
      else
        render json: @userTime.errors, status: :unprocessable_entity
      end
    else
      render json: 'You not authorized', status: 403
    end
  end

  def update
    if (current_user.id.to_s == @userTime[:user_id].to_s) || admin_user?(@user)

      if @userTime.update(userTime_params)
        render json: @userTime
      else
        render json: @userTime.errors, status: :unprocessable_entity
      end
    else
      render json: 'You not authorized', status: 403
    end
  end

  def destroy
    if (current_user.id.to_s == @userTime[:user_id].to_s) || admin_user?(@user)
      @userTime.destroy
    else
      render json: 'You not authorized', status: 403
    end
  end

  private

  def correct_user
    @user = current_user
    render json: 'You not authorized', status: 403 unless current_user?(@user)
  end

  def normal_user
    @user = current_user
    render json: 'You not authorized', status: 403 unless normal_user?(@user) || admin_user?(@user)
  end

  def admin_user
    @user = current_user
    render json: 'You not authorized', status: 403 unless admin_user?(@user)
  end

  def manager_user
    @user = current_user
    render json: 'You not authorized', status: 403 unless user_manager?(@user)
  end

  def set_userTime
    @userTime = UserTime.find(params[:id])
  end

  def userTime_params
    params.require(:userTime).permit(:user_id, :time, :distance, :date)
  end
end
