// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unsplash_app/providers/user_provider.dart';
import 'package:unsplash_app/responsive/mobile_screen_layout.dart';
import 'package:unsplash_app/responsive/responsive_layout_screen.dart';
import 'package:unsplash_app/responsive/web_screen_layout.dart';
// import 'package:unsplash_app/screens/signup_screen.dart';
import 'package:unsplash_app/utils/colors.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyC9kbiYqblqaMZl_7trYi3UFoyOcc-31Wo',
        appId: '1:979694002352:web:3418bf3cbd381426a99b75',
        messagingSenderId: '979694002352',
        projectId: 'unsplash-app-2b74b',
        storageBucket: 'unsplash-app-2b74b.appspot.com',
      ),
    );
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
          // home: ResponsiveLayout(
          //   webScreenLayout: WebScreenLayout(),
          //   mobileScreenLayout: MobileScreenLayout(),
          // ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                    webScreenLayout: WebScreenLayout(),
                    mobileScreenLayout: MobileScreenLayout(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
              return const LoginScreen();
            },
          )),
    );
  }
}
