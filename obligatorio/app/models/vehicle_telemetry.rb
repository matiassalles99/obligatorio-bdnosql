class VehicleTelemetry
  attr_accessor :guid, :pressure, :velocity, :wind_velocity, :captured_at

  alias_attribute :capturedat, :captured_at
  alias_attribute :windvelocity, :wind_velocity

  class << self
    def from_hash(hash)
      record = self.new
      hash.each do |key, value|
        record.send("#{key}=", value)
      end

      record
    end
  end
end
