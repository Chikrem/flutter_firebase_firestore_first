// Final Main

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_firestore_first/_core/mycolors.dart';
import 'package:flutter_firebase_firestore_first/authentication/screens/auth_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.brown),
        appBarTheme: const AppBarTheme(
          color: MyColors.brown,
          toolbarHeight: 72,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: MyColors.brown,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: MyColors.green,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: MyColors.blue,
        ),
        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}
