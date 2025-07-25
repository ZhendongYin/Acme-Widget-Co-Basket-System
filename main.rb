# frozen_string_literal: true

require_relative 'lib/product'
require_relative 'lib/special_offer'
require_relative 'lib/delivery_rule'
require_relative 'lib/basket'

special_offers = SpecialOffer.all
delivery_rules = DeliveryRule.all
products = Product.all

basket = Basket.new(offers: special_offers, rules: delivery_rules)

puts "Welcome to Acme Widget Co Basket CLI!"
puts "Available commands:"
puts "  add <CODE>   - Add a product by code (e.g., add R01)"
puts "  total        - Show current basket total"
puts "  clear        - Clear the basket"
puts "  list         - List all available products"
puts "  items        - Show current basket contents"
puts "  exit         - Exit the program"

loop do
  print "> "
  input = gets&.strip
  break if input.nil?
  cmd, *args = input.split
  case cmd
  when 'add'
    code = args[0]
    product = Product.find_by(code: code)
    if product
      basket.add(product)
      puts "Added #{product.name} (#{product.code}) - $#{product.price}"
    else
      puts "Product code not found. Use 'list' to see available codes."
    end
  when 'total'
    puts "Current total: $#{basket.total}"
  when 'clear'
    basket = Basket.new(offers: special_offers, rules: delivery_rules)
    puts "Basket cleared."
  when 'list'
    puts "Available products:"
    products.each { |p| puts "  #{p.code}: #{p.name} ($#{p.price})" }
  when 'items'
    if basket.items.empty?
      puts "Basket is empty."
    else
      puts "Basket contains:"
      basket.items.group_by(&:code).each do |code, items|
        prod = products.find { |p| p.code == code }
        puts "  #{code}: #{prod.name} x#{items.size} ($#{prod.price})"
      end
    end
  when 'exit'
    puts "Goodbye!"
    break
  else
    puts "Unknown command. Available: add <CODE>, total, clear, list, items, exit"
  end
end
