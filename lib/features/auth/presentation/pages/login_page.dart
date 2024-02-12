import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survey/common/app_route.dart';
import 'package:synapsis_survey/features/auth/bloc/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nikController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final authBloc = context.read<AuthBloc>()..add(OnCheckIsLogin());
    authBloc.stream.listen((state) {
      if (state is AuthCookie) {
        if (state.isLogin == true) {
          Navigator.pushNamed(context, AppRoute.home);

          print("oke gas oke gas");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is AuthCookie) {}

              return SizedBox();
            }),
            TextField(
              controller: nikController,
              decoration: InputDecoration(
                labelText: 'NIK',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is AuthFailure) {
                return Text(
                  state.message,
                  style: TextStyle(color: Colors.red),
                );
              }

              return SizedBox();
            }),
            const SizedBox(height: 20),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return ElevatedButton(
                    onPressed: () {},
                    child: CircularProgressIndicator(),
                  );
                }

              
                return ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika untuk proses login di sini
                    String nik = nikController.text;
                    String password = passwordController.text;

                    FocusManager.instance.primaryFocus?.unfocus();

                    context
                        .read<AuthBloc>()
                        .add(OnAuthLogin(nik: nik, password: password));
                  },
                  child: const Text('Login'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
