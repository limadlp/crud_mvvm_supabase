import 'package:crud_mvvm_supabase/app/viewmodels/auth_view_model.dart';
import 'package:crud_mvvm_supabase/app/views/auth/login_page.dart';
import 'package:crud_mvvm_supabase/app/views/crud/item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    void logout() async {
      await authViewModel.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginPage()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome, ${authViewModel.getCurrentUserEmail() ?? 'User'}!'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ItemListView()));
              },
              child: const Text('Go to Items'),
            ),
          ],
        ),
      ),
    );
  }
}
