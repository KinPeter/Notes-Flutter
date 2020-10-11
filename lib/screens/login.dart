import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    String _email = DotEnv().env['PK_EMAIL'];
    String _password = DotEnv().env['PK_PASSWORD'];

    return Container();
  }
}

