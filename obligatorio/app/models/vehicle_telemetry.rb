class VehicleTelemetry
  include ActiveModel::Model
  include Cassandra::Model

  attributes :city, :pressure, :velocity, :wind_velocity, :captured_at
  table_name 'vehicleTelemetry'

  validates :city, :pressure, :velocity, :wind_velocity, presence: true

  class << self
    def fillable
      %i[city pressure velocity wind_velocity]
    end
  end

  def prepare_for_cassandra_insert
    self.captured_at = Time.zone.now
    self.pressure = pressure.to_f
    self.velocity = velocity.to_f
    self.wind_velocity = wind_velocity.to_f
  end
end
