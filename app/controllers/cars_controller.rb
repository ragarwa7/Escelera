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
    @car = Car.find(params[:id])
    @car.status = "Available"
    @booking = Booking.where("car_id = ? AND pickup_time <= ? AND return_time >=  ?",params[:id],DateTime.now.to_s(:db),DateTime.now.to_s(:db))
    if @booking.exists?
      @car.status = @booking.last["status"].capitalize
    end

  end

  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url }
      format.json { head :no_content }
    end
  end

  def index
    @search = Car.search(params[:q])
    @cars = @search.result
    if (current_user.try(:user?))
      @booking = Booking.where(:user_id => current_user.id).where.not(status: 3).to_a()
    else
      @booking = []
    end

    if @booking.length <= 0 then
      @cars.each do |car|
        car.status = car_status car
      end
    else
      @cars = []
    end
    @cars
  end

  def show
  end

  def search
    @search = Car.search(params[:q])
    @cars = @search.result
  end

  def bookings
    @bookings = Booking.find_by_car_id(params[:car_id])
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

    def car_status car
      @booking = Booking.where("car_id = ? AND pickup_time <= ? AND return_time >=  ?",car.id,DateTime.now.to_s(:db),DateTime.now.to_s(:db))
      status = "Available"
      if @booking.exists?
        booking = @booking.last
        user = User.find(booking["user_id"])
        status = booking["status"].capitalize + " by " + view_context.link_to(user.name, user_path(user))
      end
      status
    end
end
