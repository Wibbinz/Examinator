
//Alerts user if username or password textboxes are empty.
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

//Generates a random strink and sends the string along with the userinput email address
//to the database through an asynchronous ajax call on the web method 'forgotPassword' located
//in the PasswordResetService service. The label is populated with the appropriate message
//if the email does not exist in the database or the password is successfully reset.
function forgotPW() {
    var email = document.getElementById("tbEmailReset").value;
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

//Alerts user if username, password or email address textboxes are empty, or
//if the user email is not in the correct format.
function RegsValidate() {
    var user = document.getElementById("tbUser");
    var password = document.getElementById("tbPW");
    var email = document.getElementById("tbEmail");
    if (user.value == '') {
        alert('Enter Username.');
        return false;
    }
    else if (password.value == '') {
        alert('Enter Password.');
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
        window.location = document.getElementById('newRegsClose').href;
        return true;
    }
}

//Alerts the user if the username or password textboxes are empty for the preferences window.
function PrefsValidate() {
    var user = document.getElementById("tbChangeuserName");
    var password = document.getElementById("tbChangePassword");
    if (user.value == '') {
        alert('Enter Username.');
        return false;
    }
    else if (password.value == '') {
        alert('Enter Password.');
        return false;
    }
    else {
        return true;
    }
}

//Sets the focus to the appropriate textbox for the modal windows.
function regsFocus() {
    var regsBox = document.getElementById("tbUser");
    regsBox.focus();
}

function forgotpwFocus() {
    var forgotBox = document.getElementById("tbEmailReset");
    forgotBox.focus();
}

function prefsFocus() {
    var prefsBox = document.getElementById("tbChangeuserName");
    prefsBox.focus();
}