import 'package:cubit_auth/cubit/cubit/auth_cubit.dart';
import 'package:cubit_auth/views/auth_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.email.toString()),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccessful) {
                  if (state.user == null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const AuthView(),
                    ));
                  }
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().signOut();
                    },
                    child: const Text('Sign Out'));
              },
            )
          ],
        ),
      ),
    );
  }
}
