import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:provider/provider.dart';
import 'package:traveloop/providers/auth_provider.dart' as traveloop_auth;

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart'; // You may need to create this widget for text fields

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<traveloop_auth.AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextField(
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              CustomButton(
                text: 'Login',
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    setState(() {
                      _isLoading = true;
                    });

                    try {
                      await authProvider.signIn(
                        _emailController.text,
                        _passwordController.text,
                      );
                      Navigator.of(context).pushReplacementNamed('/home');
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/signup');
                },
                child: const Text('Don\'t have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
