require 'yaml'

class BaseModel
  def self.all
    load_all_from_yaml(self::YAML_PATH)
  end

  def self.load_all_from_yaml(path, key: nil)
    data = YAML.load_file(path)
    records = key ? data[key] : data
    records.map { |attrs| new(attrs) }
  end

  def self.find_by(query)
    all.find { |obj| query.all? { |k, v| obj.send(k) == v } }
  end

  def initialize(attrs = {})
    attrs.each do |k, v|
      singleton_class.class_eval { attr_accessor k.to_sym } unless respond_to?(k)
      send("#{k}=", v)
    end
  end
end
