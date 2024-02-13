import 'package:flutter/material.dart';
import 'package:synapsis_survey/common/app_route.dart';
import 'package:synapsis_survey/common/theme.dart';
import 'package:synapsis_survey/features/auth/bloc/bloc/auth_bloc.dart';
import 'package:synapsis_survey/features/auth/presentation/pages/login_page.dart';
import 'package:synapsis_survey/features/survey/bloc/detail/survey_question_bloc.dart';
import 'package:synapsis_survey/features/survey/bloc/survey_bloc.dart';
import 'package:synapsis_survey/features/survey/presentation/bloc/question_number_cubic.dart';
import 'package:synapsis_survey/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider(create: (context) => QuestionNumberCubit()),
        BlocProvider(create: (_) => locator<AuthBloc>()),
        BlocProvider(create: (_) => locator<SurveyBloc>()),
        BlocProvider(create: (_) => locator<SurveyQuestionBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: primaryColor,
            textTheme: GoogleFonts.interTextTheme(),
            scaffoldBackgroundColor: Colors.white),
        initialRoute: AppRoute.login,
        onGenerateRoute: AppRoute.onGenerateRoute,
        home: const LoginPage(),
      ),
    );
  }
}
