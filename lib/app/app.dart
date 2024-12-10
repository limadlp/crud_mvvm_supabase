import 'package:crud_mvvm_supabase/app/repositories/item_repository.dart';
import 'package:crud_mvvm_supabase/app/services/auth/auth_service.dart';
import 'package:crud_mvvm_supabase/app/services/auth/supabase_auth_provider.dart';
import 'package:crud_mvvm_supabase/app/services/datasource/supabase_service.dart';
import 'package:crud_mvvm_supabase/app/viewmodels/auth_view_model.dart';
import 'package:crud_mvvm_supabase/app/viewmodels/item_view_model.dart';
import 'package:crud_mvvm_supabase/app/views/auth/login_page.dart';
import 'package:crud_mvvm_supabase/app/views/auth/register_page.dart';
import 'package:crud_mvvm_supabase/app/views/crud/item_list_view.dart';
import 'package:crud_mvvm_supabase/app/views/error/error_page.dart';
import 'package:crud_mvvm_supabase/app/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService(SupabaseAuthProvider());
    final backendService = SupabaseService(Supabase.instance.client);

    final itemRepository = ItemRepository(backendService);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel(authService)),
        ChangeNotifierProvider(create: (_) => ItemViewModel(itemRepository)),
      ],
      child: Builder(builder: (context) {
        final GoRouter router = GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              name: 'home',
              path: '/',
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(
              name: 'item_list_view',
              path: '/items',
              builder: (context, state) => const ItemListView(),
            ),
            GoRoute(
              name: 'login',
              path: '/login',
              builder: (context, state) => const LoginPage(),
            ),
            GoRoute(
              name: 'register',
              path: '/register',
              builder: (context, state) => const RegisterPage(),
            ),
          ],
          redirect: (context, state) {
            // Redireciona com base no estado de login
            final loggedIn = authService.isLoggedIn();

            if (!loggedIn) {
              // Redireciona para a tela de login se não estiver logado
              return '/login';
            } else if (loggedIn) {
              // Redireciona para a home se já estiver logado
              return '/';
            }

            // Não redireciona
            return null;
          },
          errorBuilder: (context, state) => const ErrorPage(),
        );

        return MaterialApp.router(
          routerConfig: router,
          // title: _getPageTitle(
          //     router.routerDelegate.currentConfiguration.uri.path),
        );
      }),
    );
  }

  // String _getPageTitle(String path) {
  //   final Map<String, String> titles = {
  //     '/': 'Home',
  //     '/login': 'Login',
  //     '/register': 'Register',
  //     '/items': 'Items',
  //   };

  //   return '${titles[path] ?? 'Not Found'} | CRUD MVVM App';
  // }
}
