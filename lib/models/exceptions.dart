class CustomException implements Exception {
  String error;
  CustomException(this.error);
}

class ItemExistsException extends CustomException {
  ItemExistsException(super.error);
}

class GeneralException extends CustomException {
  GeneralException(super.error);
}
