class CarsController < ApplicationController
  before_action :authorize_user, only: [:index, :show]
  before_action :authorize_admin, only: [:new, :create, :destroy, :edit, :update]
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render action: 'show', status: :created, location: @car }
      else
        format.html { render action: 'new' }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def edit
  end

  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url }
      format.json { head :no_content }
    end
  end

  def index
    @booking = Booking.where("user_id = ?", current_user.id)
    if @booking.length > 0 then
      @cars = []
    else
      @cars = Car.all
    end
  end

  def show
  end

  def authorize_user
    return unless !user_signed_in?
    redirect_to root_path, alert: 'Please login first!'
  end

  def authorize_admin
    return unless !current_user.try(:admin?) and !current_user.try(:superadmin?)
    redirect_to root_path, alert: 'This page is for Admin or Super Admin only!'
  end

  private

    def set_car
      @car = Car.find(params[:id])
    end

    def car_params
      params.require(:car).permit(:model, :manufacturer, :number,
                                  :rate, :style, :location, :status)
    end
end
