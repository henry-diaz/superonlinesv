json.success @success
json.set! 'product-id', @item.product_id
json.message @success ? 'Item agregado con éxito' : 'Hubo un problema al agregar el item'
