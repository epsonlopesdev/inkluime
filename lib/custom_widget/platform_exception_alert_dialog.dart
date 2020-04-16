
import 'package:app/custom_widget/platform_alert_dialog.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super (
      title: title,
      content: _message(exception),
      defaultActionText: 'Fechar',
  );

  static String _message(PlatformException exception) {
    print(_errors[exception.code]);

    /*if (exception.details == 'Missing or insufficient permissions.') {
      if (exception.code == 'PERMISSION_DENIED') {
        return 'Ops! parece que você não tem permissão pra fazer isso... :(';
      }
    }*/

    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {

    ///   • `ERROR_WEAK_PASSWORD` - If the password is not strong enough.
    'ERROR_INVALID_EMAIL': 'E-mail informado é inválido!',
    ///   • `ERROR_EMAIL_ALREADY_IN_USE` - If the email is already in use by a different account.
    ///   • `ERROR_INVALID_EMAIL` - If the [email] address is malformed.
    'ERROR_WRONG_PASSWORD':  'E-mail e/ou Senha, inválidos!',
    'ERROR_USER_NOT_FOUND': 'E-mail e/ou Senha, inválidos!',
    'PERMISSION_DENIED': 'Ops! parece que você não tem permissão pra fazer isso... :(',
    ///   • `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
    ///   • `ERROR_TOO_MANY_REQUESTS` - If there was too many attempts to sign in as this user.
    ///   • `ERROR_OPERATION_NOT_ALLOWED` - Indicates that Email & Password accounts are not enabled.

  };
}