class VehicleTelemetry
  include ActiveModel::Model
  include Cassandra::Model

  attributes :guid, :pressure, :velocity, :wind_velocity, :captured_at
  table_name 'vehicleTelemetry'

  validates :pressure, :velocity, :wind_velocity, presence: true

  class << self
    def fillable
      %i[pressure velocity wind_velocity]
    end
  end

  def prepare_for_cassandra_insert
    self.guid = SecureRandom.uuid[0,5]
    self.captured_at = Time.zone.now
    self.pressure = pressure.to_f
    self.velocity = velocity.to_f
    self.wind_velocity = wind_velocity.to_f
  end
end
