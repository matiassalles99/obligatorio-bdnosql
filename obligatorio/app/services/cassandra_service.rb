require 'cassandra'

class CassandraService
  include Singleton

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

  def get_all(klass:)
    execute(statement: generate_get_statement(klass: klass), klass: klass)
  end

  def insert(record:)
    execute(statement: generate_insert_statement(record: record), klass: record.class)
  end

  private

  attr_reader :client

  def execute(statement:, klass:)
    records = []

    client.execute(statement).each do |row|
      records << klass.from_hash(row.deep_symbolize_keys!)
    end

    records
  end

  def generate_get_statement(klass:)
    "SELECT * FROM #{KEYSPACE}.#{klass.table};"
  end

  def generate_insert_statement(record:)
    klass = record.class
    hash = record.to_hash

    values = hash.values.map do |value|
      if value.is_a?(Float)
        value
      else
        "'#{value}'"
      end
    end

    "INSERT INTO #{KEYSPACE}.#{klass.table} (#{hash.keys.join(', ')}) VALUES (#{values.join(', ')});"
  end
end
