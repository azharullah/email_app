$(document).ready(function() {

    var baseUrl = 'http://127.0.0.1:5000/';
    var user_name = localStorage.getItem('name');
    var user_email = localStorage.getItem('email');

    // Replace user name
    $('#name').text(user_name);

    // Activate tabs
    $('.tabs').tabs();

    // Activate FAB
    $('.fixed-action-btn').floatingActionButton();

    // Activate select dropdowns
    $('select').formSelect();

    // Simulate inbox click for first time
    var url = baseUrl + 'user/"' + user_email + '"/inbox';
    populateEmails(url = url, enable_forward = true, enable_delete = true, type = 'inbox');


    // Handle inbox tab click
    $('#inbox_tab').click(function() {
        var url = baseUrl + 'user/"' + user_email + '"/inbox';
        populateEmails(url = url, enable_forward = true, enable_delete = true, type = 'inbox');
    })

    // Handle sent tab click
    $('#sent_tab').click(function() {
        var url = baseUrl + 'user/"' + user_email + '"/sent';
        populateEmails(url = url, enable_forward = true, enable_delete = true, type = 'sent');
    })

    // Handle drafts tab click
    $('#drafts_tab').click(function() {
        var url = baseUrl + 'user/"' + user_email + '"/drafts';
        populateEmails(url = url, enable_forward = false, enable_delete = true, type = 'drafts');
    })

    // Handle trash tab click
    $('#trash_tab').click(function() {
        var url = baseUrl + 'user/"' + user_email + '"/trash';
        populateEmails(url = url, enable_forward = false, enable_delete = false, type = 'trash');
    })

    function formRows(data, enable_forward, enable_delete, type) {
        var rowsContent = ""
        data.forEach(function(email) {

            // Add from / to email(s)
            if (type == 'inbox') extraText = '(From: ' + email[1] + ') '
            else extraText = '(To: ' + JSON.parse(email[2]).join(',') + ') '

            // Differentiate between seen and unseen
            if (type == 'inbox') {
                if ($.inArray(user_email, JSON.parse(email[5] || '[]')) != -1) var bgColor = 'white'
                else var bgColor = 'lightyellow'
            }

            rowContent = '<li id="' + email[0] + '" class="collection-item" style="background-color:' + bgColor + '"> \
                            <div> ' + extraText + email[3] + '<a href="#modal" class="secondary-content"> \
                            <i class="material-icons view_icon">open_in_new</i> &nbsp;&nbsp;'

            // Decide icons based on tab
            if (enable_forward) rowContent += '<i class="material-icons forward_icon">forward</i> &nbsp;&nbsp;'
            if (enable_delete) rowContent += '<i class="material-icons delete_icon">delete</i>'
            rowContent += '</a></div></li>'

            rowsContent += rowContent
        });

        // Replace the tab content
        $('#' + type + '_list').empty()
        $('#' + type + '_list').append(rowsContent);
    }

    function populateEmails(url, enable_forward, enable_delete, type) {
        var settings = {
            "async": true,
            "crossDomain": true,
            "url": url,
            "method": "GET",
        }
        $.ajax(settings).done(function(response) {
            if (response.success) {
                formRows(response.data, enable_forward, enable_delete, type);
            } else {
                console.log('Fetching data failed ', response.data)
                alert('Fetching data failed ', response.data)
            }
        });
    }

    function createModal(emailId) {
        var settings = {
            "async": true,
            "crossDomain": true,
            "url": baseUrl + 'emails/' + emailId,
            "method": "GET",
        }
        $.ajax(settings).done(function(response) {
            if (response.success) {
                $('.view_modal').modal();
                $('.view_modal').modal('open');

                // Replace values appropriately
                var res = response.data[0];
                $('#modal_from').text(res[1]);
                $('#modal_to').text(JSON.parse(res[2]).join(','));
                $('#modal_date').text(res[10]);
                $('#modal_subject').text(res[3]);
                $('#modal_body').text(res[4]);
            } else {
                console.log('Fetching data failed ', response.data)
                alert('Fetching data failed ', response.data)
            }

            // if the email is not already read, mark it as read
            if ($.inArray(user_email, JSON.parse(res[5] || '[]')) == -1) {
                payload = {
                    'email': user_email
                }
                var settings = {
                    "async": true,
                    "crossDomain": true,
                    "url": baseUrl + 'emails/' + res[0] + '/mark_as_read',
                    "headers": {
                        "content-type": "application/json"
                    },
                    "method": "POST",
                    "data": JSON.stringify(payload),
                }
                $.ajax(settings).done(function(response) {
                    if (response.success) {
                        console.log('Successfully marked email as read')
                    } else {
                        console.log('Posting data failed ', response.data)
                        alert('Posting data failed ', response.data)
                    }
                });
            }
        });
    }

    // Handle email open
    $(document).on('click', '.view_icon', function() {
        var emailId = $(this).parent().parent().parent().attr('id');
        createModal(emailId = emailId)
    });

    // Handle email forward
    $(document).on('click', '.forward_icon', function() {
        alert('Not implemented yet!');
    });

    // Handle email delete
    $(document).on('click', '.delete_icon', function() {
        var emailId = $(this).parent().parent().parent().attr('id');
        var settings = {
            "async": true,
            "crossDomain": true,
            "url": baseUrl + 'emails/' + emailId,
            "method": "DELETE",
        }
        $.ajax(settings).done(function(response) {
            if (response.success) {
                alert('Email has been moved to trash')
            } else {
                console.log('Fetching data failed ', response.data)
                alert('Fetching data failed ', response.data)
            }
        });
    });

    // Handle compose button click
    $('#compose_button').click(function() {
        $('.compose_modal').modal();
        $('.compose_modal').modal('open');

        // Fetch all users
        var settings = {
            "async": false,
            "crossDomain": true,
            "url": baseUrl + 'users',
            "method": "GET",
        }
        $.ajax(settings).done(function(response) {
            if (response.success) {
                var autocompleteData = {}
                response.data.forEach(function(user) {
                    autocompleteData[user[0]] = null;
                })

                // Populate chips
                $('.chips').chips();
                $('.chips-placeholder').chips({
                    placeholder: 'Enter emails of people to send'
                });
                $('.chips-autocomplete').chips({
                    autocompleteOptions: {
                        data: autocompleteData,
                        limit: Infinity,
                        minLength: 1
                    }
                });
            } else {
                console.log('Fetching data failed ', response.data)
                alert('Fetching data failed ', response.data)
            }
        });

    })

    // Handle compose submit
    $('#compose_submit').click(function() {
        var receiver_emails = []
        M.Chips.getInstance($('.chips')).chipsData.forEach(function(mailId) {
            receiver_emails.push(mailId['tag'])
        })
        payload = {
            'sender_email': user_email,
            'receiver_emails': receiver_emails,
            'subject': $('#compose_subject').val(),
            'body': $('#compose_body').val()
        }
        var settings = {
            "async": true,
            "crossDomain": true,
            "url": baseUrl + 'emails',
            "method": "POST",
            "data": JSON.stringify(payload),
            "headers": {
                "content-type": "application/json"
            },
            "processData": false
        }
        $.ajax(settings).done(function(response) {
            if (response.success) {
                alert('Successfully send the email!')
            } else {
                console.log('Login failed', response.data)
                alert('Login failed', response.data)
            }
        });
    });

})