import 'package:flutter/material.dart';
import 'package:notes/screens/edit_note.dart';
import 'package:notes/screens/login.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Menu'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add new note'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(EditNoteScreen.routeName);
            },
          ),
          Divider(),
          if (!auth.isAuth) ListTile(
            leading: Icon(Icons.login),
            title: Text('Log in'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          ),
          if (auth.isAuth) ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log out'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              auth.logOut();
            },
          ),
        ],
      ),
    );
  }
}