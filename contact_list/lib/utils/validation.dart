bool isEmailValid (String email) {
  var emailRegex = RegExp(r"[\w-\.]+@([\w-]+\.)+[\w-]{2,4}");
  return emailRegex.hasMatch(email);
}

bool isNumberValid(String telefone) {
  var numberRegex = RegExp(r"([1-9]{2}) (?:[2-8]|9[1-9])[0-9]{3}-[0-9]{4}");
  return numberRegex.hasMatch(telefone);
}