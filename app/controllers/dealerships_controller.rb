class DealershipsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_dealership, only: [:show, :edit, :update, :destroy]

  # GET /dealerships
  def index
    @dealerships = Dealership.order('dealerships.created_at desc').page(params[:page])
  end

  # GET /dealerships/1
  def show
  end

  # GET /dealerships/new
  def new
    @dealership = Dealership.new
  end

  # GET /dealerships/1/edit
  def edit
  end

  # POST /dealerships
  def create
    @dealership = Dealership.new(dealership_params)

    if @dealership.save
      redirect_to dealerships_url, notice: 'Dealership was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /dealerships/1
  def update
    if @dealership.update(dealership_params)
      redirect_to dealerships_url, notice: 'Dealership was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /dealerships/1
  def destroy
    @dealership.destroy
    redirect_to dealerships_url, notice: 'Dealership was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dealership
      @dealership = Dealership.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dealership_params
      params[:dealership].permit!
    end
end
