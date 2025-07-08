import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, required this.submit, required this.isLogin});

  final Function() submit;
  final bool isLogin;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String _enteredEmail = '';
  String _enteredPassword = '';

  void _submit() {
    bool isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
    }
    print(_enteredEmail);
    print(_enteredPassword);
    widget.submit;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            decoration: InputDecoration(
              label: Text('E-mail'),
            ),
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  !value.contains('@')) {
                return 'Insira um e-mail válido';
              }
              return null;
            },
            onSaved: (newValue) => _enteredEmail = newValue!,
          ),
          TextFormField(
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            decoration: InputDecoration(
              label: Text('Password'),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.trim().length < 6) {
                return 'A senha deve ter pelo menos 6 caracteres';
              }
              return null;
            },
            onSaved: (newValue) => _enteredPassword = newValue!,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submit,
            child: Text(widget.isLogin ? 'Entrar' : 'Cadastrar'),
          ),
        ],
      ),
    );
  }
}
