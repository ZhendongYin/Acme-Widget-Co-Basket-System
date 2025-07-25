# frozen_string_literal: true

require_relative 'base_model'

class DeliveryRule < BaseModel
  YAML_PATH = 'data/delivery_rules.yml'

  def self.calculate_delivery(rules, subtotal)
    rules.each do |r|
      min = r.respond_to?(:min) ? r.min.to_f : 0
      max = r.respond_to?(:max) ? r.max.to_f : Float::INFINITY
      if subtotal >= min && subtotal < max
        return r.charge
      end
    end
    0.0
  end
end 