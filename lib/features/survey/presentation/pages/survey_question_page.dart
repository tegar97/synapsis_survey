import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:synapsis_survey/common/theme.dart';
import 'package:synapsis_survey/features/survey/bloc/detail/survey_question_bloc.dart';
import 'package:synapsis_survey/features/survey/bloc/detail/survey_question_state.dart';
import 'package:synapsis_survey/features/survey/bloc/survey_bloc.dart';
import 'package:synapsis_survey/features/survey/domain/entities/question_entity.dart';
import 'package:synapsis_survey/features/survey/presentation/bloc/question_number_cubic.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:synapsis_survey/features/survey/presentation/bloc/timer_cubit.dart';
import 'package:synapsis_survey/features/survey/presentation/bloc/timer_state.dart';

class SurveyQuestionPage extends StatefulWidget {
  final String surveyId;

  const SurveyQuestionPage({super.key, required this.surveyId});

  @override
  State<SurveyQuestionPage> createState() => _SurveyQuestionPageState();
}

class _SurveyQuestionPageState extends State<SurveyQuestionPage> {
  late List<String> sections;
  final questionNumberController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<QuestionNumberCubit>().clearNumberQuestion();

    context.read<TimerCubit>().startTimer();

    context
        .read<SurveyQuestionBloc>()
        .add(OnGetSurveyQuestion(widget.surveyId));
  }

  @override
  void dispose() {
    context.read<QuestionNumberCubit>().clearNumberQuestion();
    context.read<TimerCubit>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        onPopInvoked: (bool didPop) {
          if (didPop) {
            context.read<TimerCubit>().resetTimer();
          }
        },
        child: BlocBuilder<SurveyQuestionBloc, SurveyQuestionState>(
          builder: (context, state) {
            if (state is SurveyQuestionLoading) {
              return CircularProgressIndicator();
            }
            if (state is SurveyQuestionFailure) {
              return Text(state.message);
            }
            if (state is SurveyQuestionLoaded) {
              sections = [];
              for (var question in state.data.question) {
                if (!sections.contains(question.section)) {
                  sections.add(question.section);
                }
              }

              return BlocBuilder<QuestionNumberCubit, int>(
                builder: (context, stateNumber) {
                  if (stateNumber < state.data.question.length) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () => {
                                    _showCustomDialog(context,
                                        state.data.question, stateNumber)
                                  },
                              child: Text(
                                  '${state.data.question[stateNumber].number} / ${state.data.question.length}')),
                          BlocBuilder<TimerCubit, TimerState>(
                            builder: (context, state) {
                              if (state is TimerInitial) {
                                return Text('Timer not started');
                              } else if (state is TimerRunInProgress) {
                                return Text(
                                    'Time remaining: ${context.read<TimerCubit>().formatDuration(state.remainingTime)}');
                              } else if (state is TimerRunPause) {
                                return Text(
                                    'Timer paused at ${state.remainingTime} seconds');
                              } else if (state is TimerRunComplete) {
                                return Text('Timer completed!');
                              }
                              return Container(); // Handle other states if needed
                            },
                          ),
                          Text(state.data.question[stateNumber].section),
                          Text(state.data.question[stateNumber].questionName),
                          Text('Total Sections: ${sections.length}'),
                          Text(
                              'Current Section: ${sections.indexOf(state.data.question[stateNumber].section) + 1}'),
                          Column(
                            children: buildOptions(
                                state.data.question[stateNumber].options,
                                state.data.question[stateNumber].type),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (stateNumber >= 1) {
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
      ),
    );
  }

  void _showCustomDialog(BuildContext context,
      List<QuestionItemEntity> questions, int stateNumber) {
    List<String> sections = [];
    for (var question in questions) {
      if (!sections.contains(question.section)) {
        sections.add(question.section);
      }
    }

    int totalPages = questions.length;

    YYDialog().build(context)
      ..width = double.infinity
      ..height = 200
      ..borderRadius = 4.0
      ..gravity = Gravity.top
      ..widget(Padding(
        padding: EdgeInsets.all(defPadding),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: AspectRatio(
                aspectRatio: 3,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: sections.length,
                  controller: questionNumberController,
                  itemBuilder: (context, index) {
                    List<QuestionItemEntity> sectionQuestions = questions
                        .where(
                            (question) => question.section == sections[index])
                        .toList();
                    return _buildSectionPage(
                        context, sectionQuestions, stateNumber, index);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                controller: questionNumberController,
                count: sections.length,
                effect: WormEffect(
                  dotColor: Colors.grey[300]!,
                  activeDotColor: Theme.of(context).primaryColor,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
            ),
          ],
        ),
      ))
      ..animatedFunc = (child, animation) {
        return ScaleTransition(
          child: child,
          scale: Tween(begin: 0.0, end: 1.0).animate(animation),
        );
      }
      ..show();
  }

  Widget _buildSectionPage(BuildContext context,
      List<QuestionItemEntity> questions, int currentNumber, int sectionIndex) {
    print(sectionIndex);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8, // Jarak horizontal antara item
        mainAxisSpacing: 8, // Jarak vertikal antara item
      ),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        bool isCurrentNumber =
            questions[index].number == (currentNumber + 1).toString();

        return GestureDetector(
          onTap: () {
            context
                .read<QuestionNumberCubit>()
                .jumpToQuestion(int.parse(questions[index].number) - 1);
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
                color: isCurrentNumber ? primaryColor : null,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xff787878))),
            child: Center(child: Text(questions[index].number)),
          ),
        );
      },
    );
  }

  List<Widget> buildOptions(List<OptionEntity>? options, String type) {
    if (options == null || options.isEmpty) {
      return []; // Return an empty list if options is null or empty
    }
    return options.map<Widget>((option) {
      switch (type) {
        case 'checkbox':
          return CheckboxListTile(
            title: Text(option.optionName),
            value: false, // Ubah ini ke nilai sesuai kebutuhan Anda
            onChanged: (value) {
              // Tambahkan logika yang sesuai saat kotak centang diubah
            },
          );
        case 'multiple_choice':
          return RadioListTile(
            title: Text(option.optionName),
            value: false, // Ubah ini ke nilai sesuai kebutuhan Anda
            groupValue: null, // Ubah ini ke nilai grup sesuai kebutuhan Anda
            onChanged: (value) {
              // Tambahkan logika yang sesuai saat tombol radio diubah
            },
          );
        case 'text':
          return TextFormField(
            decoration: InputDecoration(labelText: option.optionName),
            onChanged: (value) {
              // Tambahkan logika yang sesuai saat teks berubah
            },
          );
        default:
          return SizedBox(); // Tambahkan widget kosong jika tidak ada jenis yang cocok
      }
    }).toList();
  }
}
