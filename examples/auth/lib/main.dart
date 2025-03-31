import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';

import 'providers/auth_provider.dart';
import 'views/auth_view.dart';
import 'views/home_view.dart';
import 'views/splash.dart';

Future<void> main() async {
  await MegaFlutter.initialize(
    baseUrl: 'https://611679f21c592d0017bb7f41.mockapi.io/api/v1/',
    authProvider: MockedAuthProvider(),
  );
  await MegaFlutter.instance.auth.findCurrentUser();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MegaFlutter Auth example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashView(),
        '/auth': (context) => AuthView(),
        '/home': (context) => HomeView(),
      },
    );
  }
}
