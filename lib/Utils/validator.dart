import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';

class Validator {
  static bool isEmpty(String? value) {
    return value?.isEmpty ?? true;
  }

  static String? isEmailValid(BuildContext context, {String? email}) {
    var emailRegExp = RegExp("[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@" "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" "(" "\\." "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" ")+");
    if (isEmpty(email)) {
      return context.l10n.emailIsRequired;
    } else if (!emailRegExp.hasMatch(email ?? '')) {
      return  context.l10n.enterValidEmail;
    }
    return null;
  }

  static String? isValidPassword(BuildContext context, {String? password}) {
    if (isEmpty(password)) {
      return  context.l10n.passwordIsRequired;
    } else if ((password?.trim().length ?? 0) < 8) {
      return  context.l10n.shortPasswordMsg;
    }
    return null;
  }

  static String? isValidMessage(BuildContext context, {String? message}){
    if(isEmpty(message ?? '')){
      return context.l10n.messageIsRequired;
    }
    return null;
  }
}
