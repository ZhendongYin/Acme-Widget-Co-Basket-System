# frozen_string_literal: true

class Basket
  attr_reader :items

  def initialize(offers: [], rules: [])
    @offers = offers
    @rules = rules
    @items = []
  end

  def add(product)
    raise "Invalid product" unless product
    @items << product
  end

  def total
    subtotal = @items.sum { |product| product.price.to_f }
    discount = SpecialOffer.total_discount(@offers, @items, @items)
    delivery = DeliveryRule.calculate_delivery(@rules, subtotal - discount)
    total = subtotal - discount + delivery
    total.round(2)
  end
end
