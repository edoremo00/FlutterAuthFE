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
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
