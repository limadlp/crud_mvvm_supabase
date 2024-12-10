import 'package:crud_mvvm_supabase/app/viewmodels/auth_view_model.dart';
import 'package:crud_mvvm_supabase/app/views/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    void register() async {
      await authViewModel.signUp(emailController.text, passwordController.text);
      if (authViewModel.errorMessage.isEmpty) {
        context.goNamed('login');
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
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
            ElevatedButton(onPressed: register, child: const Text('Register')),
            TextButton(
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const LoginPage())),
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
