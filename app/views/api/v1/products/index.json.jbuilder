json.products @products, partial: 'api/v1/products/product', as: :product
json.total_count @products.respond_to?(:total_entries) ? @products.total_entries : @products.to_a.count
