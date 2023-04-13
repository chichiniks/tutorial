import 'package:fellowship/auth/auth_page.dart';
import 'package:fellowship/pages/main_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../pages/home_page.dart';
import 'package:fellowship/pages/main_home.dart';
import '../auth/account_info.dart';
import '../pages/questionnaire_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return FilterChipDisplay(); //originally HomePage()
            }
            else {
              return AuthPage();
            }
          },
      ),
    );
  }
}