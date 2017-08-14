class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.order('users.created_at desc').page(params[:page])
    @users = @users.where({dealership_id: current_dealership.id}) if !current_user.admin?
  end

  def show
    redirect_to root_path, notice: flash[:notice], error: flash[:error]
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_url, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user.technician? ? technicians_users_path : users_url, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # def new_technician
  #   @user = User.new
  # end
  #
  # def create_technician
  #   @user = User.new(user_params)
  #   if @user.save
  #     redirect_to technicians_users_path, notice: "Technician created successfully."
  #   else
  #     render 'new_technician'
  #   end
  # end
  #
  # def technicians
  #   @users = if current_user.admin?
  #              User.technician
  #            elsif current_user.dealership_id?
  #              current_user.dealership.users.technicians
  #            else
  #              User.none
  #            end.order('users.created_at desc').page(params[:page])
  # end
  #
  # def service_advisors
  #   @users = current_user.dealership.users.service_advisor
  # end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_url, notice: 'User was successfully destroyed.'
    else
      redirect_to users_url, notice: 'Error while destroying a user.'
    end
  end

  def login_as
    @service_advisors = current_user.dealership.users.service_advisor
    @technicians = current_user.dealership.users.technician
  end

  def login
    @user = User.find(params[:id])
    sign_in(:user, @user)
    redirect_to after_sign_in_path_for(@user), notice: "You are currently logged in as #{@user.role.humanize.downcase} #{@user.name_or_email_or_username}"
  end

  private
  def user_params
    if params[:user] && params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :last_name, :email, :role, :dealership_id)
  end
end
