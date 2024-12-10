import 'package:crud_mvvm_supabase/app/repositories/item_repository.dart';
import 'package:crud_mvvm_supabase/app/services/auth/auth_service.dart';
import 'package:crud_mvvm_supabase/app/services/auth/supabase_auth_provider.dart';
import 'package:crud_mvvm_supabase/app/services/datasource/supabase_service.dart';
import 'package:crud_mvvm_supabase/app/viewmodels/auth_view_model.dart';
import 'package:crud_mvvm_supabase/app/viewmodels/item_view_model.dart';
import 'package:crud_mvvm_supabase/app/views/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      child: const MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
