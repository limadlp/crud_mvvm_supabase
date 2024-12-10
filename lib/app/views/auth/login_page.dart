import 'package:crud_mvvm_supabase/app/viewmodels/auth_view_model.dart';
import 'package:crud_mvvm_supabase/app/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    void login() async {
      await authViewModel.signIn(emailController.text, passwordController.text);
      if (authViewModel.errorMessage.isEmpty && authViewModel.isLoggedIn()) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (authViewModel.errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(authViewModel.errorMessage,
                    style: const TextStyle(color: Colors.red)),
              ),
            if (authViewModel.isLoading) const CircularProgressIndicator(),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: login, child: const Text('Login')),
            TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const RegisterPage())),
              child: const Text('Don’t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
