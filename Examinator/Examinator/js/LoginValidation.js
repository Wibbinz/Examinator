function checkLogin() {
    var user = document.getElementById("tbLogin");
    var password = document.getElementById("tbPassword");
    if (user.value == '') {
        alert("Please enter a valid Username!");
        return false;
    }
    else if (password.value == '') {
        alert("Please enter a valid Password!");
        return false;
    }
    else {
        return true;
    }
}

function forgotPW() {
    var email = prompt("Please enter the email address used when registering.");
    var randomLetters = Math.random().toString(36).slice(2, 6) + Math.random().toString(36).slice(2);
    $.ajax({
        type: "POST",
        url: "/PasswordResetService.asmx/forgotPassword",
        contentType: "application/json",
        data: JSON.stringify({ "emailAddress": email, "newPassword": randomLetters }),
        success: function (data) {
            var successMessage = $("#lblPasswordResult");
            successMessage.html(data.d);
        },
        error: function (error) {
            var errorMessage = $("#lblPasswordResult");
            errorMessage.html(error.responseText);
        }
    });
}

function RegsValidate() {
    var user = document.getElementById("tbUser");
    var password = document.getElementById("tbPW");
    var firstName = document.getElementById("tbFirstName");
    var lastName = document.getElementById("tbLastName");
    var email = document.getElementById("tbEmail");
    if (user.value == '') {
        alert('Enter Username.');
        return false;
    }
    else if (password.value == '') {
        alert('Enter Password.');
        return false;
    }
    else if (firstName.value == '') {
        alert('Enter First Name.');
        return false;
    }
    else if (lastName.value == '') {
        alert('Enter Last Name.');
        return false;
    }
    else if (email.value == '') {
        alert('Enter Email Address.');
        return false;
    }
    else {
        var x = email.value;
        var atpos = x.indexOf('@');
        var dotpos = x.lastIndexOf('.');
        if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) {
            alert('Email address invalid!');
            return false;
        }
        return true;
    }
}