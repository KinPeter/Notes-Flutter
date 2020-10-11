import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:notes/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    String _email = DotEnv().env['PK_EMAIL'];
    String _password = DotEnv().env['PK_PASSWORD'];

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Log in'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Log in'),
          onPressed: () {
            Provider.of<Auth>(context, listen: false).logIn();
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
      ),
    );
  }
}

