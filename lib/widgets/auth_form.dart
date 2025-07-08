import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, required this.submit, required this.isLogin});

  final Function(String email, String password) submit;
  final bool isLogin;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String _enteredEmail = '';
  final _passwordController = TextEditingController();

  void _submit() {
    bool isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    widget.submit(_enteredEmail, _passwordController.text);
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
            controller: _passwordController,
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
          ),
          widget.isLogin
              ? SizedBox()
              : TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  decoration: InputDecoration(
                    label: Text('Confirm password'),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'As senhas estão diferentes';
                    }
                    return null;
                  },
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
