import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survey/common/app_route.dart';
import 'package:synapsis_survey/features/auth/bloc/bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              context.read<AuthBloc>().add(OnLogout());
              Navigator.pushReplacementNamed(context, AppRoute.login);
            }, child: Text("Logout"))
          ],
        )
      ),
    );
  }
}