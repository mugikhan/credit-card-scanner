class CustomException implements Exception {
  String error;
  CustomException(this.error);
}

class ItemExistsException extends CustomException {
  ItemExistsException(super.error);
}
