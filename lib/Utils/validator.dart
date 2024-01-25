import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Utils/app_localization.dart';

class Validator {
  static bool isEmpty(String? value) {
    return value?.isEmpty ?? true;
  }

  static String? isEmailValid({String? email}) {
    var emailRegExp = RegExp("[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@" "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" "(" "\\." "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" ")+");
    if (isEmpty(email)) {
      return AppLocalization.instance.keys.emailIsRequired;
    } else if (!emailRegExp.hasMatch(email ?? '')) {
      return  AppLocalization.instance.keys.enterValidEmail;
    }
    return null;
  }

  static String? isValidPassword({String? password}) {
    if (isEmpty(password)) {
      return  AppLocalization.instance.keys.passwordIsRequired;
    } else if ((password?.trim().length ?? 0) < 8) {
      return  AppLocalization.instance.keys.shortPasswordMsg;
    }
    return null;
  }

  static String? isValidConfirmPassword({String? password, String? matchPassword}) {
    if (isEmpty(password)) {
      return  AppLocalization.instance.keys.passwordIsRequired;
    } else if ((password?.trim().length ?? 0) < 8) {
      return  AppLocalization.instance.keys.shortPasswordMsg;
    } else if (password != matchPassword) {
      return AppLocalization.instance.keys.passwordMismatch;
    }
    return null;
  }

  static String? emptyValidate({String? value, String? message}){
    if(isEmpty(value ?? '')){
      return message;
    }
    return null;
  }
  static String? isValidName({String? name}) {
    var nameRegexp = RegExp(r"^[a-zA-Z ]+$");
    if (isEmpty(name)) {
      return  AppLocalization.instance.keys.nameIsRequired;
    } else if (!nameRegexp.hasMatch(name ?? '')) {
      return AppLocalization.instance.keys.enterValidName;
    }
    return null;
  }
}
