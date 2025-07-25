# Acme Widget Co Basket System

## Project Overview

This project is a basket checkout system for Acme Widget Co, featuring:
- All products, delivery rules, and special offers are YAML-configurable
- Highly decoupled business logic, easy to extend
- Ruby metaprogramming: all model fields are auto-mapped from YAML
- Supports tiered delivery, BOGO/discount offers, and more

## Main Files

```
.
├── main.rb                  # Command-line interactive basket tool
├── test/
│   └── test_basket.rb       # Runs challenge test cases and prints results
├── lib/
│   ├── base_model.rb        # Base model, auto-loads YAML and fields
│   ├── product.rb           # Product model
│   ├── special_offer.rb     # Special offer model (e.g., BOGO half price)
│   ├── delivery_rule.rb     # Delivery rule model, supports ranges and free delivery
│   └── basket.rb            # Basket, collects products and calculates totals
└── data/
    ├── products.yml         # Product config
    ├── special_offers.yml   # Special offer config
    └── delivery_rules.yml   # Delivery rule config
```

## How to Run the Challenge Test Cases

1. Install Ruby
2. Enter the project directory
3. Run the test file:

```bash
ruby test/test_basket.rb
```

You will see output like:
```
Basket: B01, G01 => Total: $37.85 (Expected: $37.85) [PASS]
Basket: R01, R01 => Total: $54.37 (Expected: $54.37) [PASS]
Basket: R01, G01 => Total: $60.85 (Expected: $60.85) [PASS]
Basket: B01, B01, R01, R01, R01 => Total: $98.27 (Expected: $98.27) [PASS]
```

## How to Use the Interactive CLI

1. Install Ruby
2. Enter the project directory
3. Run the main CLI tool:

```bash
ruby main.rb
```

You can then use commands like:
- `add R01`   (add a product by code)
- `total`     (show current basket total)
- `clear`     (clear the basket)
- `list`      (list all available products)
- `items`     (show current basket contents)
- `exit`      (exit the program)

## Data Files
- **data/products.yml**: List of products, each with code, name, price
- **data/special_offers.yml**: Special offers, supports various types (percentage, fixed discount, etc.)
- **data/delivery_rules.yml**: Delivery fee ranges, supports min/max and free delivery

## Extending
- Add new products/offers/delivery rules by editing YAML files—no Ruby code changes needed
- All model fields are auto-mapped, no manual attribute declaration
