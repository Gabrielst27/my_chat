import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.submit,
    required this.isLogin,
    required this.isLoading,
  });

  final Function(String name, String email, String password) submit;
  final bool isLogin;
  final bool isLoading;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String _enteredName = '';
  String _enteredEmail = '';
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  void _submit() {
    bool isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    widget.submit(_enteredName, _enteredEmail, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!widget.isLogin)
            TextFormField(
              enabled: !widget.isLoading,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              decoration: InputDecoration(
                label: Text('Nome'),
                prefixIcon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.name,
              autocorrect: false,
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty ||
                    value.trim().length < 4 ||
                    value.trim().length > 32) {
                  return 'O nome deve ter entre 4 e 32 caracteres';
                }
                return null;
              },
              onSaved: (newValue) => _enteredName = newValue!,
            ),
          TextFormField(
            enabled: !widget.isLoading,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            decoration: InputDecoration(
              label: Text('E-mail'),
              prefixIcon: Icon(Icons.email),
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
            enabled: !widget.isLoading,
            controller: _passwordController,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            decoration: InputDecoration(
              label: Text('Senha'),
              prefixIcon: Icon(Icons.password),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.trim().length < 6) {
                return 'A senha deve ter pelo menos 6 caracteres';
              }
              return null;
            },
          ),
          if (!widget.isLogin)
            TextFormField(
              enabled: !widget.isLoading,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              decoration: InputDecoration(
                label: Text('Confirme a senha'),
                prefixIcon: Icon(Icons.password),
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
            onPressed: widget.isLoading ? null : _submit,
            child: widget.isLoading
                ? CircularProgressIndicator(
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                  )
                : Text(widget.isLogin ? 'Entrar' : 'Cadastrar'),
          ),
        ],
      ),
    );
  }
}
