product ||= @product

if product.nil?
  json.status 404
  json.error "Couldn't find Product with id=#{params[:id]}"
else
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
end
