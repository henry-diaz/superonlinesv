$(document).ready(function () {
	// Decalarations
	var baseUrl = 'http://www.superonlinesv.com/api/v1/';
	var key = "AABsAABkA";
	// Login
	var username;
	var pass;
	$('#login-form').submit(function () {
		var $inputs = $('#login-form :input');
		var values = {};
		$inputs.each(function () {
			values[this.name] = $(this).val();
		});
		username = values['username'];
		pass = values['password'];
		login(username, pass);
		event.preventDefault();
	});

	var login = function (username, pass) {
		var requestUrl = 'accounts/login';
		var requestParameters = {
			username: username,
			pass: pass,
		}
		requestHandler('POST', requestUrl, requestParameters,
			doneLogin, errorLogin, alwaysLogin);
	};

	var doneLogin = function (data, textStatus, jqXHR) {
		if (data.success) {
			if (data['cart-token'] == null && !checkCookie('cart-token')) {
				var cartToken = calcMD5(Date.now().toString());
			} else {
				console.log('la cookie ya existe');
			}
			var u = username;
				var p = pass;
				username = null;
				pass = null;
				setCookie("cart-token", cartToken, 1);
				setCookie("u", u, 1);
				setCookie("p", p, 1);
				getUser();
		} else {
			$('#login-form').find("input[type=text], input[type=password]").val("");
			$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
				'<button type="button" class="close" data-dismiss="alert">×</button>' +
				'<strong>Error!</strong> El usuario o clave proporcionado no es válido.' +
				'</div>');
		}
	};
	var errorLogin = function (jqXHR, textStatus, errorThrown) {
		$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
			'<button type="button" class="close" data-dismiss="alert">×</button>' +
			'<strong>Error!</strong> Hubo un problema, intente iniciar sesión nuevamente más tarde.' +
			'</div>');
	};
	var alwaysLogin = function (data, textStatus, errorThrown) {
		return;
	};
	// Login End
	
	// Signin
	$('#signin-form').submit(function () {
		var $inputs = $('#signin-form :input');
		var values = {};
		$inputs.each(function () {
			values[this.name] = $(this).val();
		});
		if (values['pass'] != values['confirmpass']) {
			$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
				'<button type="button" class="close" data-dismiss="alert">×</button>' +
				'<strong>Error!</strong> Las claves no coinciden.' +
				'</div>');
			event.preventDefault();
			return;
		}
		var pass = values['pass'];
		if (pass.length < 8) {
			$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
				'<button type="button" class="close" data-dismiss="alert">×</button>' +
				'<strong>Error!</strong> La clave es muy corta, debe contener al menos 8 caracteres.' +
				'</div>');
			event.preventDefault();
			return;
		}
		var requestUrl = 'accounts/signin';
		var requestParameters = {
			name: values['name'],
			username: values['username'],
			pass: values['pass'],
			email: values['email'],
			address: values['address'],
			phone: values['phone'],
			'credit-card': values['credit-card'],
		}
		requestHandler('POST', requestUrl, requestParameters,
			doneSignin, errorSignin, alwaysSignin);
		event.preventDefault();
	});
	var doneSignin = function (data, textStatus, jqXHR) {
		if (data.success) {
			$('#signin-form').find("input[type=text], input[type=password], input[type=email]").val("");
			$('#alert-container').html('<div class="alert alert-dismissible alert-success">' +
				'<button type="button" class="close" data-dismiss="alert">×</button>' +
				'<strong>¡Completado!</strong> Ahora puedes iniciar sesión con tu nuevo usuario.' +
				'</div>');
		} else {
			var errors;
			data.errors.forEach(function (element) {
				errors = element + ' ';
			}, this);
			$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
				'<button type="button" class="close" data-dismiss="alert">×</button>' +
				'<strong>Error!</strong> ' + errors + '.' +
				'</div>');
		}
	};
	var errorSignin = function (jqXHR, textStatus, errorThrown) {
		$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
			'<button type="button" class="close" data-dismiss="alert">×</button>' +
			'<strong>Error!</strong> Hubo un problema, intente registrarse nuevamente más tarde.' +
			'</div>');
	};
	var alwaysSignin = function (data, textStatus, errorThrown) {
		return;
	};
	// Signin End
	
	// Add Cart
	$(document).on('click', '.add-to-cart', function () {
		console.log('hitted');
		var productId = $(this).data('productid');
		addToCart(productId, 1);
		event.preventDefault();
	});

	var addToCart = function (productId, quantity) {
		console.log(productId + ' :: ' + quantity);
		if (quantity == 0 || quantity == null || quantity == '')
			return;

		var cartToken = getCookie('cart-token');
		console.log('GetCartToken' + cartToken);
		if (cartToken == '') {
			cartToken = calcMD5(Date.now().toString());
			setCookie("cart-token", cartToken, 1);
		}

		var requestUrl = 'carts/add';
		var requestParameters = {
			'cart-token': cartToken,
			'product-id': productId,
			quantity: quantity
		}
		console.log(requestParameters);
		requestHandler('POST', requestUrl, requestParameters,
			doneAddCart, errorAddCart, alwaysAddCart);
		//event.preventDefault();
	};

	var doneAddCart = function (data, textStatus, jqXHR) {
		if (data.success) {
			$('#alert-container').html('<div id="itemAdded" class="alert alert-dismissible alert-success">' +
				'<button type="button" class="close" data-dismiss="alert">×</button>' +
				'<strong>¡Agregado!</strong> Este item se agregó a tu carrito de compra.' +
				'</div>' +
				'<script>setTimeout(function(){$("#itemAdded").remove();}, 2000);</script>');
		} else {
			var errors;
			data.errors.forEach(function (element) {
				errors = element + ' ';
			}, this);
			$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
				'<button type="button" class="close" data-dismiss="alert">×</button>' +
				'<strong>Error!</strong> ' + errors + '.' +
				'</div>');
		}
	};
	var errorAddCart = function (jqXHR, textStatus, errorThrown) {
		$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
			'<button type="button" class="close" data-dismiss="alert">×</button>' +
			'<strong>Error!</strong> Hubo un problema, este item no fue agregado al carrito.' +
			'</div>');
	};
	var alwaysAddCart = function (data, textStatus, errorThrown) {
		return;
	};
	// Add Cart End
	
	// Remove Cart
	$(document).on('click', '.remove-from-cart', function () {
		var productId = $(this).data('productid');
		removeFromCart(productId);
	});

	var removeFromCart = function (productId) {
		var cartToken = getCookie('cart-token');
		if (cartToken == '') {
			event.preventDefault();
			return;
		}

		var requestUrl = 'carts/remove';
		var requestParameters = {
			'product-id': productId,
			'cart-token': cartToken,
		}
		console.log(requestParameters);
		requestHandler('POST', requestUrl, requestParameters,
			doneRemoveCart, errorRemoveCart, alwaysRemoveCart);
		event.preventDefault();
	};

	var doneRemoveCart = function (data, textStatus, jqXHR) {
		if (data.success) {
			getCart();
		} else {
			var errors;
			data.errors.forEach(function (element) {
				errors = element + ' ';
			}, this);
			$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
				'<button type="button" class="close" data-dismiss="alert">×</button>' +
				'<strong>Error!</strong> ' + errors + '.' +
				'</div>');
		}
	};
	var errorRemoveCart = function (jqXHR, textStatus, errorThrown) {
		$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
			'<button type="button" class="close" data-dismiss="alert">×</button>' +
			'<strong>Error!</strong> Hubo un problema, este item no fue removido del carrito.' +
			'</div>');
	};
	var alwaysRemoveCart = function (data, textStatus, errorThrown) {
		return;
	};
	// Remove Cart End
	
	// Update Cart
	var quantity = 0;
	$(document).on('change', '.cart_quantity_input', function () {
		var productId = $(this).data('productid');
		quantity = $(this).val();

		var cartToken = getCookie('cart-token');
		if (cartToken == '') {
			event.preventDefault();
			return;
		}

		var requestUrl = 'carts/remove';
		var requestParameters = {
			'product-id': productId,
			'cart-token': cartToken,
		}

		requestHandler('POST', requestUrl, requestParameters,
			doneUpdateCart, errorUpdateCart, alwaysUpdateCart);
		event.preventDefault();
	});

	var doneUpdateCart = function (data, textStatus, jqXHR) {
		if (data.success) {
			addToCart(data['product-id'], quantity);
			getCart();
		} else {
			var errors;
			data.errors.forEach(function (element) {
				errors = element + ' ';
			}, this);
			$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
				'<button type="button" class="close" data-dismiss="alert">×</button>' +
				'<strong>Error!</strong> ' + errors + '.' +
				'</div>');
		}
	};
	var errorUpdateCart = function (jqXHR, textStatus, errorThrown) {
		$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
			'<button type="button" class="close" data-dismiss="alert">×</button>' +
			'<strong>Error!</strong> Hubo un problema, este item no fue actualizado.' +
			'</div>');
	};
	var alwaysUpdateCart = function (data, textStatus, errorThrown) {
		return;
	};
	// Update Cart End
	
	// Get Cart
	$('#update-cart').click(function () {
		getCart();
		event.preventDefault();
	});

	var getCart = function () {
		var cartToken = getCookie('cart-token');
		if (cartToken == '') {
			$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
				'<button type="button" class="close" data-dismiss="alert">×</button>' +
				'<strong>Carrito vacío</strong> No has iniciado tu proceso de compras aún.' +
				'</div>');
			return;
		}
		console.log(cartToken);
		var requestUrl = 'carts?cart-token=' + cartToken;
		requestHandler('GET', requestUrl, null,
			doneGetCart, errorGetCart, alwaysGetCart);
	};

	var doneGetCart = function (data, textStatus, jqXHR) {
		if (data.products.lenght != 0) {
			var subtotal = 0;
			$('#cart-details').html('');
			data.products.forEach(function (element) {
				if (element.id != null) {
					subtotal += element.quantity * element.price;
					$('#cart-details').append(
						'<tr>' +
						'<td class="cart_product">' +
						'<a href=""><img src="' + element.image + '" alt="" style="max-height:60px;"></a>' +
						'</td>' +
						'<td class="cart_description">' +
						'<h4><a href="">' + element.name + '</a></h4>' +
						'<p>Web ID: ' + element.sku + '</p>' +
						'</td>' +
						'<td class="cart_price">' +
						'<p>$' + element.price + '</p>' +
						'</td>' +
						'<td class="cart_quantity">' +
						'<div class="cart_quantity_button">' +
						//'<a class="cart_quantity_up" href=""> + </a>' +
						'<input data-productid="' + element.id + '" class="cart_quantity_input" type="text" name="quantity" value="' + element.quantity + '" autocomplete="off" size="2">' +
						//'<a class="cart_quantity_down" href=""> - </a>' +
						'</div>' +
						'</td>' +
						'<td class="cart_total">' +
						'<p class="cart_total_price">$' + element.quantity * element.price + '</p>' +
						'</td>' +
						'<td class="cart_delete">' +
						'<a class="remove-from-cart cart_quantity_delete" data-productid="' + element.id + '" href=""><i class="fa fa-times"></i></a>' +
						'</td>' +
						'</tr>');
				}
			}, this);
			$('#cart-subtotal').html('$' + subtotal.toFixed(2));
			$('#cart-total').html('$' + subtotal.toFixed(2));
		} else {
			console.log('malo');
		}
		event.preventDefault();
	};
	var errorGetCart = function (jqXHR, textStatus, errorThrown) {
		$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
			'<button type="button" class="close" data-dismiss="alert">×</button>' +
			'<strong>Error!</strong> Hubo un problema, no se pudo obtener el carrito de compra.' +
			'</div>');
	};
	var alwaysGetCart = function (data, textStatus, errorThrown) {
		return;
	};
	// Get Cart End
	
	// Get Products
	var categorySelected = "featured";

	$('.menu-category').click(function () {
		var category = $(this).data('category');
		categorySelected = category;
		getProducts();
		event.preventDefault();
	});

	var getProducts = function () {
		var requestUrl = 'products';
		var requestParameters = '';

		requestHandler('GET', requestUrl, requestParameters,
			doneGetProducts, errorGetProducts, alwaysGetProducts);
		event.preventDefault();
	};

	var doneGetProducts = function (data, textStatus, jqXHR) {

		if (data.products.length != 0) {
			var featured = Array();
			var Abarrotes = Array();
			var Bebidas = Array();
			var Bakery = Array();
			var carnes = Array();
			var Tecnologia = Array();
			var ofertas = Array();

			data.products.forEach(function (element) {
				if (element.featured)
					featured.push(element);

				switch (element.category) {
					case 'Abarrotes':
						Abarrotes.push(element);
						break;
					case 'Bebidas':
						Bebidas.push(element);
						break;
					case 'Bakery':
						Bakery.push(element);
						break;
					case 'carnes':
						carnes.push(element);
						break;
					case 'Tecnologia':
						Tecnologia.push(element);
						break;
					case 'ofertas':
						ofertas.push(element);
						break;
				}
			}, this);

			var category = Array();
			switch (categorySelected) {
				case 'featured':
					category = featured;
					$('category-title').html('Lo más pedido');
					break;
				case 'abarrotes':
					category = Abarrotes;
					$('category-title').html('Abarrotes');
					break;
				case 'bebidas':
					category = Bebidas;
					$('category-title').html('Bebidas');
					break;
				case 'bakery':
					category = Bakery;
					$('category-title').html('Bakery');
					break;
				case 'carnes':
					category = carnes;
					$('category-title').html('Carnes');
					break;
				case 'tecnologia':
					category = Tecnologia;
					$('category-title').html('Tecnología');
					break;
				case 'ofertas':
					category = ofertas;
					$('category-title').html('Ofertas');
					break;
			}
			$('#featured-items').html('');
			category.forEach(function (element) {
				$('#featured-items').append(
					'<div class="col-sm-4">' +
					'<div class="product-image-wrapper">' +
					'<div class="single-products">' +
					'<div class="productinfo text-center">' +
					'<div style="min-height:166px;max-width:146px;"><img class="text-center" src="' + element.image + '" alt="" /></div>' +
					'<h2>$' + element.price + '</h2>' +
					'<p>' + element.name + '</p>' +
					'<a href="#" class="btn btn-default add-to-cart" data-productId="' + element.id + '" ><i class="fa fa-shopping-cart"></i>Agregar al carrito</a>' +
					'</div>' +
					'<div class="product-overlay">' +
					'<div class="overlay-content">' +
					'<h2>$' + element.price + '</h2>' +
					'<p>' + element.name + '</p>' +
					'<a href="#" class="btn btn-default add-to-cart" data-productId="' + element.id + '"><i class="fa fa-shopping-cart"></i>Agregar al carrito</a>' +
					'</div>' +
					'</div>' +
					'</div>' +
					'<div class="choose">' +
					'<ul class="nav nav-pills nav-justified">' +
					'</div>' +
					'</div>' +
					'</div>');
			}, this);
		} else {
			var errors;
			data.errors.forEach(function (element) {
				errors = element + ' ';
			}, this);
			$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
				'<button type="button" class="close" data-dismiss="alert">×</button>' +
				'<strong>Error!</strong> ' + errors + '.' +
				'</div>');
		}
	};
	var errorGetProducts = function (jqXHR, textStatus, errorThrown) {
		$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
			'<button type="button" class="close" data-dismiss="alert">×</button>' +
			'<strong>Error!</strong> Hubo un problema, no se encontraron productos.' +
			'</div>');
	};
	var alwaysGetProducts = function (data, textStatus, errorThrown) {
		return;
	};
	// Get Products End
	
	// Get User
	var getUser = function () {
		var requestUrl = 'accounts/profile';
		
		var u = getCookie('u');
		var p = getCookie('p');
		
		
		var username =u;
		var pass = p;

		var requestParameters = {
			'username': username,
			'pass': pass,
		}
		console.log(requestParameters);
		requestHandler('POST', requestUrl, requestParameters,
			doneGetUser, errorGetUser, alwaysGetUser);
		event.preventDefault();
	};
	var doneGetUser = function (data, textStatus, jqXHR) {
		if (data.success) {
			setCookie("name", data.user.name, 1);
			window.location.replace("index.html");
		} else {
			var errors;
			data.errors.forEach(function (element) {
				errors = element + ' ';
			}, this);
			$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
				'<button type="button" class="close" data-dismiss="alert">×</button>' +
				'<strong>Error!</strong> ' + errors + '.' +
				'</div>');
		}
	};
	var errorGetUser = function (jqXHR, textStatus, errorThrown) {
		$('#alert-container').html('<div class="alert alert-dismissible alert-danger">' +
			'<button type="button" class="close" data-dismiss="alert">×</button>' +
			'<strong>Error!</strong> Hubo un problema, no se pudo obtener la información del usuario.' +
			'</div>');
	};
	var alwaysGetUser = function (data, textStatus, errorThrown) {
		return;
	};
	// Get User End
	
	var welcomeUser = function () {
		if (checkCookie('name') && checkCookie('u') && checkCookie('p')){
			$("#user-name").html('Bienvenido ' + getCookie('name'));
		}else{
			$("#user-name").html('Invitado');
		}
	};

	var requestHandler = function (m, u, d, s, f, a) {
		$.ajax({
			method: m,
			url: baseUrl + u,
			data: d
		}).done(s).fail(f).always(a);
	}
	
	// Cookies
	function setCookie(cname, cvalue, exdays) {
		var d = new Date();
		d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
		var expires = "expires=" + d.toUTCString();
		document.cookie = cname + "=" + cvalue + "; " + expires;
	}

	var getCookie = function (cname) {
		var name = cname + "=";
		var ca = document.cookie.split(';');
		for (var i = 0; i < ca.length; i++) {
			var c = ca[i];
			while (c.charAt(0) == ' ') c = c.substring(1);
			if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
		}
		return "";
	}

	function checkCookie(cname) {
		var c = getCookie(cname);
		return c != '';
	}
	
	// Calls to methods
	getProducts();
	welcomeUser();
})