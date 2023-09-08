import 'package:cubit_auth/cubit/cubit/auth_cubit.dart';
import 'package:cubit_auth/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum FormState { login, signup }

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  late FormState formState;
  late String buttonText;
  late String textButtonText;
  late String headerText;

  @override
  void initState() {
    initForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              headerText,
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            TextFormField(
              controller: emailEditingController,
              decoration: const InputDecoration(
                  hintText: 'E-mail', border: OutlineInputBorder()),
            ),
            const SizedBox.square(
              dimension: 12.0,
            ),
            TextFormField(
              obscureText: true,
              controller: passwordEditingController,
              decoration: const InputDecoration(
                  hintText: 'Password', border: OutlineInputBorder()),
            ),
            const SizedBox.square(
              dimension: 12.0,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              builder: (context, state) {
                final authCubit = context.read<AuthCubit>();
                print(formState);
                return ElevatedButton(
                  onPressed: () async {
                    if (formState == FormState.login) {
                      await authCubit.loginWithEmailAndPassword(
                          emailEditingController.text,
                          passwordEditingController.text);
                    } else {
                      await authCubit.signupWithEmailAndPassword(
                          emailEditingController.text,
                          passwordEditingController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).primaryColor.withBlue(255),
                      backgroundColor: Colors.grey.shade300),
                  child: Text(buttonText),
                );
              },
              listener: (context, state) {
                if (state is AuthSuccessful) {
                  if (state.user != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeView(
                              user: state.user!,
                            )));
                  }
                } else if (state is AuthError) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(state.message),
                    ),
                  );
                }
              },
            ),
            const SizedBox.square(
              dimension: 12.0,
            ),
            TextButton(
                onPressed: () {
                  setState(changeFormState);
                },
                child: Text(textButtonText))
          ],
        ),
      ),
    ));
  }

  void initForm() {
    formState = FormState.login;
    headerText = 'Login';
    buttonText = 'Login';
    textButtonText = 'You don\'t have account, sign up!';
  }

  void changeFormState() {
    print("1$formState");
    formState =
        formState == FormState.login ? FormState.signup : FormState.login;
    print("2$formState");
    if (formState == FormState.login) {
      headerText = 'Login';
      buttonText = 'Login';
      textButtonText = 'You don\'t have account, sign up!';
    } else {
      headerText = 'Register';
      buttonText = 'Register';
      textButtonText = 'You have an account, login!';
    }
  }
}
