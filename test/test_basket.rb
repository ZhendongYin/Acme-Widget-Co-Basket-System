require_relative '../lib/product'
require_relative '../lib/special_offer'
require_relative '../lib/delivery_rule'
require_relative '../lib/basket'

special_offers = SpecialOffer.all
delivery_rules = DeliveryRule.all

def test_basket(product_codes, expected_total, special_offers, delivery_rules)
  basket = Basket.new(offers: special_offers, rules: delivery_rules)
  product_codes.each do |code|
    product = Product.find_by(code: code)
    basket.add(product)
  end
  actual = basket.total
  result = (actual.to_f.round(2) == expected_total.to_f.round(2)) ? 'PASS' : 'FAIL'
  puts "Basket: #{product_codes.join(', ')} => Total: $#{actual} (Expected: $#{expected_total}) [#{result}]"
end

test_basket(['B01', 'G01'], 37.85, special_offers, delivery_rules)
test_basket(['R01', 'R01'], 54.37, special_offers, delivery_rules)
test_basket(['R01', 'G01'], 60.85, special_offers, delivery_rules)
test_basket(['B01', 'B01', 'R01', 'R01', 'R01'], 98.27, special_offers, delivery_rules) 