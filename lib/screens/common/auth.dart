import 'package:flutter/material.dart';
import 'package:foodapp/screens/common/login_screen.dart';
import 'package:foodapp/screens/common/register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool goLogin = true;

  void toggle() {
    setState(() {
      goLogin = !goLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (goLogin) {
      return LoginScreen(onToggle: toggle);
    } else {
      return RegisterScreen(onToggle: toggle);
    }
  }
}
