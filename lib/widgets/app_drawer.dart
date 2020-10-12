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
            title: const Text('Menu'),
            automaticallyImplyLeading: false,
          ),
          if (auth.isAuth) const Divider(),
          if (auth.isAuth) ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add new note'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(EditNoteScreen.routeName);
            },
          ),
          const Divider(),
          if (!auth.isAuth) ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Log in'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(LoginScreen.routeName);
            },
          ),
          if (auth.isAuth) ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
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