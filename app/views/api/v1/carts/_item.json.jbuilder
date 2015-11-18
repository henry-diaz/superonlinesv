item ||= @item
json.id item.product_id
json.name item.product_name
json.featured item.product_featured
json.image item.product_image_url ? asset_url(item.product_image_url) : ''
json.sku item.product_sku
json.category item.product_category_name
json.brand item.product_brand_name
json.price item.product_price
json.quantity item.quantity
