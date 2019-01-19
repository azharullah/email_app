$(document).ready(function() {

    $('#login_form').submit(function(e) {
        return false;
    });

    var baseUrl = 'http://127.0.0.1:5000/';

    // Handle login
    $('#btn_login').click(function() {

        creds = {
            'email': $('#email').val(),
            'password': $('#password').val()
        }

        var settings = {
            "async": true,
            "crossDomain": true,
            "url": baseUrl + 'login',
            "method": "POST",
            "data": JSON.stringify(creds),
            "headers": {
                "content-type": "application/json"
            },
            "processData": false
        }

        $.ajax(settings).done(function(response) {
            if (response.success) {
                console.log('Login successful')
                localStorage.setItem('logged_in', true);
                localStorage.setItem('email', response.data[0][0]);
                localStorage.setItem('name', response.data[0][1]);
                window.location.replace('mail_view.html');
            } else {
                console.log('Login failed', response.data)
            }
        });
    });

})