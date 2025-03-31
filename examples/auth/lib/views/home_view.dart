import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';

import '../models/premium_user.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    MegaFlutter.instance.auth.userChanges.listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed('/auth');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = MegaFlutter.instance.auth.currentUser as PremiumUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await MegaFlutter.instance.auth.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Olá, ${user.name}!'),
            Text(
              'Sua assinatura expira no dia ${user.subscriptionExpiresAt.day}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
