import 'package:flutter/material.dart';
import 'package:migscourier/models/user.dart';
import 'package:migscourier/screens/login.dart';
import 'package:migscourier/screens/navigation.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return user != null
        ? NavigationScreen()
        : LoginScreen();
  }
}
