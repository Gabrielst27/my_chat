import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/widgets/auth_form.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  bool _isLoading = false;

  void _submit(String name, String email, String password) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
              'name': name,
              'email': email,
            });
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
      }
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message ?? 'Falha de autenticação')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Image.asset(
            'assets/images/chat.png',
            fit: BoxFit.contain,
          ),
        ),
        title: Text('MyChat'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 48, bottom: 24),
                    child: Text(
                      _isLogin ? 'Bem-vindo de volta!' : 'Crie sua conta',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(255),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: AuthForm(
                      isLogin: _isLogin,
                      isLoading: _isLoading,
                      submit: _submit,
                    ),
                  ),
                  TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                    child: Text(
                      _isLogin ? 'Criar conta' : 'Já possuo uma conta',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
