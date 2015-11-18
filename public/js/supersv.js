$(document).ready(function () {
	var baseUrl = 'http://www.superonlinesv.com/api/v1/';

	// Login
	$('#login-form').submit(function () {
		var $inputs = $('#login-form :input');
		var values = {};
		$inputs.each(function () {
			values[this.name] = $(this).val();
		});

		var requestUrl = 'accounts/login';
		var requestParameters = {
			username: values['username'],
			pass: values['password'],
		}
		requestHandler('POST', requestUrl, requestParameters,
			doneLogin, errorLogin, alwaysLogin);
		event.preventDefault();
	});
	var doneLogin = function (data, textStatus, jqXHR) {
		if (data.success) {
			if (data['cart-token'] == null && !checkCookie('cart-token')) {
				var cartToken = calcMD5(Date.now().toString());
				setCookie("cart-token", cartToken, 1);
			} else {
				console.log('la cookie ya existe');
			}
			window.location.replace("index.html");
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
	$('.add-to-cart').click(function () {
		var productId = $(this).data('productid');

		var cartToken = getCookie('cart-token');
		if (cartToken == null) {
			cartToken = calcMD5(Date.now().toString());
			setCookie("cart-token", cartToken, 1);
		}

		console.log(cartToken);

		var requestUrl = 'carts/add';
		var requestParameters = {
			'cart-token': cartToken,
			'product-id': productId,
			quantity: 1
		}
		console.log(requestParameters);
		requestHandler('POST', requestUrl, requestParameters,
			doneAddCart, errorAddCart, alwaysAddCart);
		event.preventDefault();
	});

	var doneAddCart = function (data, textStatus, jqXHR) {
		if (data.success) {
			$('#signin-form').find("input[type=text], input[type=password], input[type=email]").val("");
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
	// Get Cart
	$('#update-cart').click(function () {
		getCart();
		event.preventDefault();
	});

	var getCart = function () {
		var cartToken = getCookie('cart-token');
		if (cartToken == null) {
			// no hay carrito handle this
		}
		console.log(cartToken);
		var requestUrl = 'carts?cart-token=' + cartToken;
		requestHandler('GET', requestUrl, null,
			doneGetCart, errorGetCart, alwaysAddCart);
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
						'<a href=""><img src="' + element.image + '" alt=""></a>' +
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
						'<a class="cart_quantity_up" href=""> + </a>' +
						'<input class="cart_quantity_input" type="text" name="quantity" value="' + element.quantity + '" autocomplete="off" size="2">' +
						'<a class="cart_quantity_down" href=""> - </a>' +
						'</div>' +
						'</td>' +
						'<td class="cart_total">' +
						'<p class="cart_total_price">$' + element.quantity * element.price + '</p>' +
						'</td>' +
						'<td class="cart_delete">' +
						'<a class="cart_quantity_delete" href=""><i class="fa fa-times"></i></a>' +
						'</td>' +
						'</tr>');
				}
			}, this);
			$('#cart-subtotal').html('$' + subtotal);
			$('#cart-total').html('$' + subtotal);
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
})