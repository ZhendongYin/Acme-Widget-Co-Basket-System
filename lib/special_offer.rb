# frozen_string_literal: true

require_relative 'base_model'

class SpecialOffer < BaseModel
  YAML_PATH = 'data/special_offers.yml'

  def apply(basket_items, products)
    case type
    when 'percentage_discount'
      count = basket_items.count { |product| product.code == product_code }
      eligible_groups = count / buy_quantity
      product = products.find { |p| p.code == product_code }
      return 0 unless product && eligible_groups > 0
      discount = eligible_groups * (apply_to || 1) * product.price * (discount_percent / 100.0)
      discount.round(2)
    when 'fixed_discount'
      count = basket_items.count { |product| product.code == product_code }
      eligible_groups = count / buy_quantity
      return 0 unless eligible_groups > 0
      discount = eligible_groups * (apply_to || 1) * discount_amount
      discount.round(2)
    else
      0.0
    end
  end

  def self.total_discount(offers, basket_items, products)
    offers.sum { |offer| offer.apply(basket_items, products) }
  end
end
