
import 'package:movie_flutter_demo/Constants/app_string_constant.dart';

class Validator {
  static bool isEmpty(String value) {
    return value.isEmpty;
  }

  static String? isEmailValid(String email) {
    var emailRegExp = RegExp("[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@" "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" "(" "\\." "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" ")+");
    if (isEmpty(email)) {
      return   AppStrings.emailIsRequired;
    } else if (!emailRegExp.hasMatch(email)) {
      return  AppStrings.enterValidEmail;
    }
    return null;
  }

  static String? isValidPassword(String password) {
    if (isEmpty(password)) {
      return  AppStrings.passwordIsRequired;
    } else if (password.trim().length < 8) {
      return  AppStrings.shortPasswordMsg;
    }
    return null;
  }

  static String? isValidMessage(String message){
    if(isEmpty(message)){
      return AppStrings.messageIsRequired;
    }
    return null;
  }
}
