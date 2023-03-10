String? checkInput(value, String fieldName) {
  if (value == null || value.isEmpty) {
    return "$fieldName не должен быть пустым";
  }
  if (value.length < 2) {
    return "$fieldName должен быть от 2 символов";
  }
  if (value.length >= 30) {
    return "$fieldName должен быть до 20 символов";
  }
  return null;
}
