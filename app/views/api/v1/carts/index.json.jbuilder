json.products @items, partial: 'api/v1/carts/item', as: :item
json.total_count @items.respond_to?(:total_entries) ? @items.total_entries : @items.to_a.count
