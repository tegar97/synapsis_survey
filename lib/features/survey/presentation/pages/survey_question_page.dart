import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survey/features/survey/bloc/detail/survey_question_bloc.dart';
import 'package:synapsis_survey/features/survey/bloc/detail/survey_question_state.dart';
import 'package:synapsis_survey/features/survey/bloc/survey_bloc.dart';
import 'package:synapsis_survey/features/survey/presentation/bloc/question_number_cubic.dart';

class SurveyQuestionPage extends StatefulWidget {
  final String surveyId;

  const SurveyQuestionPage({super.key, required this.surveyId});

  @override
  State<SurveyQuestionPage> createState() => _SurveyQuestionPageState();
}

class _SurveyQuestionPageState extends State<SurveyQuestionPage> {
  @override
  void initState() {
    super.initState();
    context.read<QuestionNumberCubit>().clearNumberQuestion();

    context
        .read<SurveyQuestionBloc>()
        .add(OnGetSurveyQuestion(widget.surveyId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SurveyQuestionBloc, SurveyQuestionState>(
        builder: (context, state) {
          if (state is SurveyQuestionLoading) {
            return CircularProgressIndicator();
          }
          if (state is SurveyQuestionFailure) {
            return Text(state.message);
          }
          if (state is SurveyQuestionLoaded) {
            return BlocBuilder<QuestionNumberCubit, int>(
              builder: (context, stateNumber) {
                if (stateNumber < state.data.question.length) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.data.question[stateNumber].number),
                        ElevatedButton(
                          onPressed: () {

                              if (stateNumber > 1) {
                              context
                                  .read<QuestionNumberCubit>()
                                  .getPreviousQuestion();
                            }
     
                          },
                          child: Text("Back "),
                        ),
                        ElevatedButton(
                          onPressed: () {
                              context
                                  .read<QuestionNumberCubit>()
                                  .getNextQuestion();
                          
                          },
                          child: Text("Next question"),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text("Ini adalah pertanyaan terakhir"),
                  );
                }
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  @override
  void dispose() {
    context.read<QuestionNumberCubit>().clearNumberQuestion();
    super.dispose();
  }
}
