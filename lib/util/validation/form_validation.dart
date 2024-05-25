class Validations {
  static String? emailValidation(String? value) {
    RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (value == null || !emailRegExp.hasMatch(value)) {
      return 'Enter a correct email address';
    } else {
      return null;
    }
  }

  static String? emtyValidation(String? value) {
    if (value == null || value.trim() == '') {
      return 'fill the feild ';
    } else {
      return null;
    }
  }

  static String? conformPasswordValidation(password, conPassword) {
    if (password != conPassword || password == null || password == '') {
      return 'enter correct password';
    } else {
      return null;
    }
  }

  static numberValidation(value) {
    RegExp numberRegExp = RegExp(r'^\d+$');
    if (value == null || !numberRegExp.hasMatch(value)) {
      return 'enter correct number';
    } else {
      return null;
    }
  }
}
