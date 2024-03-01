import 'package:challenge_master/src/feautures/screens/home/home_page.dart';
import 'package:challenge_master/src/provider/library_provider.dart';
import 'package:challenge_master/src/services/auth_service/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChangeNotifierProvider(
              create: (_) => LibraryProvider(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: HomePage(),
              ),
            );
            //return const NavigationMenu();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
