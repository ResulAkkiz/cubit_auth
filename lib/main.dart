import 'package:cubit_auth/cubit/cubit/auth_cubit.dart';
import 'package:cubit_auth/firebase_options.dart';
import 'package:cubit_auth/service/firebase_auth_service.dart';
import 'package:cubit_auth/views/auth_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(FirebaseAuthService()),
      child: MaterialApp(
          theme: ThemeData(useMaterial3: true),
          title: 'Material App',
          home: const AuthView()),
    );
  }
}
