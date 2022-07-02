module Cassandra::Model
  extend ActiveSupport::Concern

  class_methods do
    def attributes(*attrs)
      attrs.each do |attr|
        class_eval { attr_accessor attr }

        if attr.to_s.include?('_')
          alias_attribute attr.to_s.remove('_').to_sym, attr
        end
      end

      define_singleton_method(:model_attributes) do
        attrs.to_a
      end
    end

    def from_hash(hash)
      record = self.new
      hash.each do |key, value|
        record.send("#{key}=", value)
      end

      record
    end

    def table_name(name)
      define_singleton_method(:table) do
        name
      end
    end
  end

  def to_hash
    hash = {}
    self.class.model_attributes.each do |attr|
      hash[attr.to_s.remove('_').to_s] = self.send(attr)
    end
    hash
  end
end
