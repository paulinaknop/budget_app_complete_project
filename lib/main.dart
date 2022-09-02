import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

import 'responsive_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    setPathUrlStrategy();
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBWlhtqte-Kt7cerX7y8_CY7rgPi5X0QK4",
        authDomain: "budget-app-ac469.firebaseapp.com",
        projectId: "budget-app-ac469",
        storageBucket: "budget-app-ac469.appspot.com",
        messagingSenderId: "354008013891",
        appId: "1:354008013891:web:03febb22f02648f53e88f6",
        measurementId: "G-2YZ4JX1KZZ",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //  theme: ThemeData(useMaterial3: true),
      home: ResponsiveHandler(),
    );
  }
}
