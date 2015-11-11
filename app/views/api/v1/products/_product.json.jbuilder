product ||= @product

json.id product['id']
json.name product['name']
json.featured product['featured']
json.image product.image ? asset_url(product.image.url) : ''
json.sku product['sku']
json.category product.category_name
json.brand product.brand_name
json.price product['price']

if product.class == ActiveRecord::Base && !product.persisted? && !product.valid?
  json.errors product.errors.messages
end
