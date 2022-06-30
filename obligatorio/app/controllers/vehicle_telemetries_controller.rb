require 'cassandra'

class VehicleTelemetriesController < ApplicationController
  def index
    statement = 'SELECT * FROM tesla.vehicleTelemetry;'
    @telemetries = CassandraService.new.execute(
      statement: statement,
      klass: VehicleTelemetry
    )
  end

  def new
  end

  def create
  end
end
