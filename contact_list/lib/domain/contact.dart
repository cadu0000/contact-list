import 'package:contact_list/utils/validation.dart';

class Contact {
  String _name = "";
  String? _number;
  String? _email;

  Contact({
    required String name,
    String? number,
    String? email,
  }) {
    if (number != null) {
      this.number = number;
    }
    if (email != null) {
      this.email = email;
    }
    this.name = name;
  }
  bool isNameValid(String name) {
    return name.isNotEmpty;
  }

  String get name => _name;

  set name(String value) {
    if (!isNameValid(value)) {
      throw const FormatException("O nome não é válido");
    }
    _name = value;
  }

  String get number => _number ?? "";

  set number(String value) {
    if (!isNumberValid(value)) {
      throw const FormatException("O número é inválido");
    }
    _number = value;
  }

  String get email => _email ?? "";

  set email(String value) {
    if (!isEmailValid(value)) {
      throw const FormatException("O e-mail é inválido");
    }
    _email = value;
  }
}
