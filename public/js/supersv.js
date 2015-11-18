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
			password: values['password'],
		}
		requestHandler('POST', requestUrl, requestParameters,
			doneLogin, errorLogin, alwaysLogin);
		event.preventDefault();
	});
	var doneLogin = function (data, textStatus, jqXHR) {
		if (data.success) {
			console.log(data);
			alert(data);
		} else {
			alert('El usuario o la clave no coinciden');
		}
	};
	var errorLogin = function (jqXHR, textStatus, errorThrown) {

	};
	var alwaysLogin = function (data, textStatus, errorThrown) {

	};
	// Login End
	

	var requestHandler = function (m, u, d, s, f, a) {
		$.ajax({
			method: m,
			url: baseUrl + u,
			data: d
		}).done(s).fail(f).always(a)
		;
	}
})