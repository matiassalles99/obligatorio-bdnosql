class VehicleTelemetriesController < ApplicationController
  def index
    @telemetries = CassandraService.instance.get_all(klass: VehicleTelemetry)
  end

  def new
    @vehicle_telemetry = VehicleTelemetry.new
  end

  def create
    @vehicle_telemetry = VehicleTelemetry.new(create_params)

    if @vehicle_telemetry.valid?
      @vehicle_telemetry.prepare_for_cassandra_insert
      CassandraService.instance.insert(record: @vehicle_telemetry)

      redirect_to vehicle_telemetries_path, status: :see_other
    else
      @error = @vehicle_telemetry.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:vehicle_telemetry).permit(VehicleTelemetry.fillable)
  end
end
