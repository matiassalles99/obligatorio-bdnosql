class CassandraService
  KEYSPACE = 'tesla'
  HOST = '127.0.0.1'
  USERNAME = 'cassandra'
  PASSWORD = 'cassandra'

  def initialize
    cluster = Cassandra.cluster(
      username: USERNAME,
      password: PASSWORD,
      hosts: [HOST]
    )
    @client = cluster.connect(KEYSPACE)
  end

  def execute(statement:, klass:)
    records = []

    client.execute(statement).each do |row|
      records << klass.from_hash(row.deep_symbolize_keys!)
    end

    records
  end

  private

  attr_reader :client
end
