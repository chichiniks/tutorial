import 'package:fellowship/auth/main_page.dart';
import 'package:fellowship/pages/cardswipe_page.dart';
import 'package:fellowship/pages/main_home.dart';
import 'package:fellowship/pages/register_page.dart';
import 'package:fellowship/pages/search_input.dart';
import 'package:fellowship/pages/util/tinder_card.dart';
import 'package:fellowship/pages/util/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:fellowship/pages/test.dart';
import 'package:fellowship/pages/saved.dart';
//import 'account_info.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true, //temp
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 8,
              primary: Colors.white,
              shape: CircleBorder(),
              minimumSize: Size.square(80),
            )
          ),
         ),
        home: MainPage(),
      ),
    );
  }
}



