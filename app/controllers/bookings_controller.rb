class BookingsController < ApplicationController
  before_action :authorize_user
  before_action :set_car

  def new
    @booking = Booking.new
    puts @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.car_id = @car.id
    @booking.user_id = current_user.id

    @pickup = @booking.pickup_time
    @return = @booking.return_time

    @temp = Booking.where("pickup_time >= ? and return_time <= ?", @pickup, @pickup).or(
            Booking.where("pickup_time >= ? and return_time <= ?", @return, @return))

    @pass = false
    @msg = ""


      if @temp.length > 0 then
        if (@pickup > @return) && (pickup > Time.now) then
          if ((@return - @pickup)/1.day).to_i <= 7 then
            if @car.save then
              @pass = true
            end
          else
            @msg = "Error: Booking period can't be more than 7 days"
          end
        else
          @msg = "Error: Please check your pickup_time and return_time"
        end
      else
        @msg = "Error: Some car is already booked within that period"
      end

    respond_to do |format|
      if @pass then
        format.html { redirect_to @booking, notice: 'Booking was successfully created' }
        format.json { render action: 'show', status: :created, location: @booking }
      else
        flash[:notice] = @msg
        format.html { render action: 'new' }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
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

  def set_car
    @car = Car.find(params[:car_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  private
    def booking_params
      params.require(:booking).permit(:pickup_time, :return_time)
    end
end
