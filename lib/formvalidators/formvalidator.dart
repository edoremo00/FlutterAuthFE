String? validateusername(String? username) {
  if (username!.isEmpty) {
    return 'username is required';
  } else if (username.startsWith(RegExp('[0-9]'))) {
    return "username can't begin with numbers";
  } else if (username.contains(' ')) {
    return "username can't contain spaces";
  } else {
    return null;
  }
}

String? validatesurname(String? surname) {
  if (surname!.isEmpty) {
    return 'surname is required';
  } else if (surname.startsWith(RegExp('[0-9]'))) {
    return "surname can't begin with numbers";
  } else if (surname.contains(' ')) {
    return "surname can't contain spaces";
  } else {
    return null;
  }
}

String? validatepassword(String? password) {
  if (password!.isEmpty) {
    return 'provide a password';
  } else if (password.contains(' ')) {
    return "password can't contain whitespaces";
  } else if (password.length < 8) {
    return "password should at least have 8 characters";
  } else if (validatepasswordstructure(password) == false) {
    return "password doesn't match requisites";
  } else {
    return null;
  }
}

bool validatepasswordstructure(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

String? validateemail(String? email) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{;|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
  RegExp regExp = RegExp(pattern);
  if (regExp.hasMatch(email!)) {
    return null;
  } else {
    return 'not a valid email';
  }
}

bool passwordmatch(String password, String confirmpassword) {
  if (password.toLowerCase() == confirmpassword.toLowerCase()) {
    return true;
  }
  return false;
}
