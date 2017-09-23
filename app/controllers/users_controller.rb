class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show_all, :edit, :show, :destroy, :update]

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def edit
    @user = User.find(params[:id])
  end

  def show_all
    @role = params[:role]
    @users = User.where(:role => User.roles[@role.to_sym]).where.not(id: current_user.id).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @bookings = Booking.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bookings }
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(user_params)
        flash[:notice] = "User #{@user.name} was successfully updated."
        format.html { redirect_to action: "show_all"}
      else
        flash[:notice] = "Please verify the details"
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      flash[:notice] = "User #{@user.name} was successfully deleted."
      format.html { redirect_to action: "show_all" }
      format.json { head :no_content }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # POST /user
  # POST /user.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        flash[:notice] = "User #{@user.name} was successfully created."
        format.html { redirect_to action: "show_all" }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
