class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    name = params[:name][3..-1]
    longitude = params[:longitude]
    latitude = params[:latitude]
    @location = Location.new
    exist_device = Device.find_by_name(name)
    if !exist_device
      device = Device.new
      device.name = name
      if device.save
        print "save device"
        @location.device_id = device.id
        @location.longitude = longitude
        @location.latitude = latitude
        if @location.save
          print "save location"
        end
      end
    else
      @location.device_id = exist_device.id
      @location.longitude = longitude
      @location.latitude = latitude
      if @location.save
        print "save location"
      end
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    name = params[:name]
    device = Device.find_by_name(name)
    @location = device.locations.last
    respond_to do |format|
      format.json { render json: @location }
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name)
    end
end
