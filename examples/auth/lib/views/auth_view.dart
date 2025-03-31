import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';

import '../models/email_credentials.dart';

class AuthView extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              initialValue: 'lucas.batista@megaleios.com',
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'E-mail',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            TextFormField(
              obscureText: true,
              initialValue: '1234',
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Senha',
                prefixIcon: Icon(Icons.vpn_key),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            ElevatedButton(
              child: Text('ENTRAR'),
              onPressed: () async {
                await MegaFlutter.instance.auth.signIn(
                  EmailCredentials(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
                if (MegaFlutter.instance.auth.currentUser != null) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
