class UsersController < ApplicationController
  before_action :authenticate_user!, only: []
  before_action :authorize_admin, only: [:new, :create, :destroy, :show_all, :edit, :show, :update]

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def edit
    @user = User.find(params[:id])
    @role = params[:role]
  end

  def show_all
    @role = params[:role]
    @users = User.where(:role => User.roles[@role.to_sym]).where.not(id: current_user.id).all

    respond_to do |format|
      format.html # index.html.erb
      format.json {render json: @users}
    end
  end

  def show
    @bookings = Booking.where(:user_id => (params[:id])).all.sort_by &:created_at
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json {render json: @bookings}
    end
  end

  def index
    if current_user.try(:admin?) then
      @bookings = Booking.joins(:car).joins(:user).all.order(:created_at).reverse_order
    end
  end

  def update
    @user = User.find(params[:id])
    @role = params[:role]

    respond_to do |format|
      if @user.update_attributes(user_params) then
        flash[:notice] = "#{@role.capitalize} #{@user.name.capitalize} was successfully updated."
        format.html {redirect_to action: "show_all", role: @role}
      else
        flash[:notice] = "Please verify the details"
        format.html {render action: "edit"}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @role = params[:role]

    return if(@role.equal?"superadmin")

    @user.destroy
    respond_to do |format|
      flash[:notice] = "#{@role.capitalize} #{@user.name.capitalize} was successfully deleted."
      format.html {redirect_to action: "show_all", role: @role}
      format.json {head :no_content}
    end
  end

  def new
    @user = User.new
    @role = params[:role]
    respond_to do |format|
      format.html # new.html.erb
      format.json {render json: @user}
    end
  end

  def booking
    @bookings = Booking.where(:user_id => current_user.id).joins(:car).order(:created_at).reverse_order.to_a()
  end

  # POST /user
  # POST /user.json
  def create
    @user = User.new(user_params)
    @role = params[:role]

    authorize_superadmin if(@role.equal?"superadmin")

    @user.role = User.roles[@role.to_sym]
    respond_to do |format|
      if @user.save
        flash[:notice] = "#{@role.capitalize} #{@user.name.capitalize} was successfully created."
        format.html {redirect_to action: "show_all", role: @role}
      else
        flash[:notice] = "Please verify the details"
        format.html {render action: "new"}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  def authorize_admin
    return unless !current_user.try(:admin?) and !current_user.try(:superadmin?)
    redirect_to root_path, alert: 'Admins only!'
  end

  def authorize_superadmin
    return unless !current_user.try(:superadmin?)
    redirect_to root_path, alert: 'Super Admins only!'
  end

end
