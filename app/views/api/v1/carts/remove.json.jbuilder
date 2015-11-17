json.success @success ? true : false
json.set! 'product-id', params['product-id']
json.message @success ? 'Item eliminado con éxito' : 'No existe el item que desea eliminar'
