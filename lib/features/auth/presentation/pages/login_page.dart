import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synapsis_survey/common/app_route.dart';
import 'package:synapsis_survey/common/theme.dart';
import 'package:synapsis_survey/common/widget/costum_form_field.dart';
import 'package:synapsis_survey/common/widget/costume_button.dart';
import 'package:synapsis_survey/features/auth/bloc/bloc/auth_bloc.dart';
import 'package:synapsis_survey/features/survey/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nikController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final authBloc = context.read<AuthBloc>()..add(OnCheckIsLogin());
    authBloc.stream.listen((state) {
      if (state is AuthCookie) {
        if (state.isLogin == true) {
          Navigator.pushReplacementNamed(context, AppRoute.home);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 24,
              ),
              Text("Login to Synapsis ", style: headerTextStyle),
              const SizedBox(
                height: 24,
              ),
              CustomFormField(
                labelText: "NIK",
                state: nikController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIK tidak boleh kosong';
                  }
                  return null;
                },
                hintText: "Masukan Nik anda",
              ),
              SizedBox(
                height: 16,
              ),
              CustomFormField(
                labelText: "Password",
                isSecure: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  return null;
                },
                state: passwordController,
                hintText: "Masukan password anda",
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                    height: 20.0,
                    width: 20.0,
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: primaryColor,
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Remember me",
                    style: bodyTextStyle.copyWith(
                        color: Color(0xff757575), fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailure) {
                    final snackBar = SnackBar(
                      content: Text(state.message),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    Text(state.message);
                  }
                  if (state is AuthLoaded) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return RoundedButton(
                      style: bodyTextStyle.copyWith(
                          fontSize: 15, color: Colors.white),
                      title: "Loading ...",
                      width: double.infinity,
                      background: Colors.grey,
                      onClick: () {},
                    );
                  }

                  return RoundedButton(
                    style: bodyTextStyle.copyWith(
                        fontSize: 15, color: Colors.white),
                    title: "Log in",
                    width: double.infinity,
                    background: primaryColor,
                    onClick: () {
                      // Tambahkan logika untuk proses login di sini
                      String nik = nikController.text;
                      String password = passwordController.text;

                      FocusManager.instance.primaryFocus?.unfocus();
                      if (_formKey.currentState!.validate()) {
                          context
                          .read<AuthBloc>()
                          .add(OnAuthLogin(nik: nik, password: password,rememberSession :rememberMe ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Mohon periksa kembali form Anda.'),
                          ),
                        );
                      }
                    
                    },
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
              Text("or",
                  style: bodyTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 16,
              ),
              RoundedOutlineButton(
                style:
                    bodyTextStyle.copyWith(fontSize: 15, color: primaryColor),
                title: "Fingerprint",
                width: double.infinity,
                color: primaryColor,
                onClick: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
