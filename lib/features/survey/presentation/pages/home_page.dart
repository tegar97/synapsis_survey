import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survey/common/app_route.dart';
import 'package:synapsis_survey/common/theme.dart';
import 'package:synapsis_survey/features/auth/bloc/bloc/auth_bloc.dart';
import 'package:synapsis_survey/features/survey/bloc/survey_bloc.dart';
import 'package:synapsis_survey/features/survey/widget/survey_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  refresh() {
    context.read<SurveyBloc>().add(OnGetAllSurvey());
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          surfaceTintColor: const Color.fromRGBO(0, 0, 0, 0),
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            "Halaman Survei",
            style: appTitleTextStyle,
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(color: primaryColor, width: 2))),
              onPressed: () {
                context.read<AuthBloc>().add(OnLogout());
                Navigator.pushReplacementNamed(context, AppRoute.login);
              },
              child: Text(
                "Logout",
                style: bodyTextStyle.copyWith(color: primaryColor),
              ),
            ),
          ]),
      body: RefreshIndicator.adaptive(
        color: primaryColor,
        onRefresh: () async => refresh(),
        child: BlocBuilder<SurveyBloc, SurveyState>(
          builder: (context, state) {
            if (state is SurveryLoaded) {
              // Jika berhasil memuat data, tampilkan daftar survei
              return ListView.builder(
                padding:
                    EdgeInsets.symmetric(horizontal: defPadding, vertical: 16),
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final survey = state.data[index];
                  return Surveyitem(survey: survey);
                },
              );
            } else if (state is SurveyLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (state is SurveyFailure) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
