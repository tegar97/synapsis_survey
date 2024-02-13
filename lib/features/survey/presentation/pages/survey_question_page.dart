import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:svg_flutter/svg.dart';
import 'package:synapsis_survey/common/theme.dart';
import 'package:synapsis_survey/common/widget/costume_button.dart';
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
      backgroundColor: Color(0xffEEF6F9),
      bottomNavigationBar: Container(
        height: 56,
        margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: BlocBuilder<QuestionNumberCubit, int>(
          builder: (context, stateNumber) {
            return Row(
              children: [
                Expanded(
                  child: RoundedOutlineButton(
                    style: bodyTextStyle.copyWith(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.w700),
                    title: "Back",
                    width: double.infinity,
                    color: primaryColor,
                    onClick: () {
                      if (stateNumber >= 1) {
                        context
                            .read<QuestionNumberCubit>()
                            .getPreviousQuestion();
                      }
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: RoundedButton(
                    style: bodyTextStyle.copyWith(
                        fontSize: 15, color: Colors.white),
                    title: "Next",
                    width: double.infinity,
                    background: primaryColor,
                    onClick: () {
                      context.read<QuestionNumberCubit>().getNextQuestion();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          BlocBuilder<SurveyQuestionBloc, SurveyQuestionState>(
            builder: (context, state) {
              return BlocBuilder<QuestionNumberCubit, int>(
                builder: (context, stateNumber) {
                  if (state is SurveyQuestionLoaded) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: GestureDetector(
                        onTap: () => {
                          _showCustomDialog(
                              context, state.data.question, stateNumber)
                        },
                        child: Container(
                          padding: EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/section_exam.svg"),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${state.data.question[stateNumber].number} / ${state.data.question.length}',
                                style: bodyTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox();
                },
              );
            },
          )
        ],
        title: BlocBuilder<TimerCubit, TimerState>(
          builder: (context, state) {
            if (state is TimerInitial) {
              return Text(
                'Timer not started',
                style: bodyTextStyle.copyWith(
                    color: primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              );
            } else if (state is TimerRunInProgress) {
              return Container(
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: primaryColor)),
                child: Text(
                  '${context.read<TimerCubit>().formatDuration(state.remainingTime)}',
                  style: bodyTextStyle.copyWith(
                      color: primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              );
            } else if (state is TimerRunPause) {
              return Text(
                'Timer paused at ${state.remainingTime} seconds',
                style: bodyTextStyle.copyWith(
                    color: primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              );
            } else if (state is TimerRunComplete) {
              return Text(
                'Finished',
                style: bodyTextStyle.copyWith(
                    color: primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              );
            }
            return Container(); // Handle other states if needed
          },
        ),
      ),
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
                    return ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.all(14),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.data.question[stateNumber].section,
                                style: bodyTextStyle.copyWith(
                                    color: Color(0xff121212),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                state.data.question[stateNumber].questionName,
                                style: bodyTextStyle.copyWith(
                                    color: Color(0xff6D6D6D),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        // Text(state.data.question[stateNumber].section),
                        // Text(state.data.question[stateNumber].questionName),
                        // Text('Total Sections: ${sections.length}'),
                        // Text(
                        //     'Current Section: ${sections.indexOf(state.data.question[stateNumber].section) + 1}'),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: EdgeInsets.all(14),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Answer",
                                style: bodyTextStyle.copyWith(
                                    color: Color(0xff121212),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: buildOptions(
                                state.data.question[stateNumber].options,
                                state.data.question[stateNumber].type),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text("Result "),
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
    int numberCurrentIndex = 0;

    List<String> sections = [];
    for (var question in questions) {
      if (!sections.contains(question.section)) {
        sections.add(question.section);
      }
    }

    int totalPages = questions.length;
    YYDialog().build(context)
      ..width = double.infinity
      ..height = 350
      ..borderRadius = 4.0
      ..gravity = Gravity.top
      ..widget(Padding(
        padding: EdgeInsets.all(defPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(builder: (context) {
                    return Text(
                      '${numberCurrentIndex}',
                      style: appTitleTextStyle,
                    );
                  }),
                  AspectRatio(
                    aspectRatio: 3,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: sections.length,
                      onPageChanged: (int page) {
                        setState(() {
                          numberCurrentIndex = page;
                        });
                      },
                      controller: questionNumberController,
                      itemBuilder: (context, index) {
                        List<QuestionItemEntity> sectionQuestions = questions
                            .where((question) =>
                                question.section == sections[index])
                            .toList();
                        return _buildSectionPage(
                            context, sectionQuestions, stateNumber, index);
                      },
                    ),
                  ),
                ],
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
            child: Center(
              child: Text(
                questions[index].number,
                style: bodyTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isCurrentNumber ? Colors.white : Color(0xff787878),
                ),
              ),
            ),
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
            value: false,
            onChanged: (value) {},
          );
        case 'multiple_choice':
          return RadioListTile(
            title: Text(option.optionName),
            value: false,
            groupValue: null,
            onChanged: (value) {},
          );
        case 'text':
          return TextFormField(
            decoration: InputDecoration(labelText: option.optionName),
            onChanged: (value) {},
          );
        default:
          return SizedBox(); // Tambahkan widget kosong jika tidak ada jenis yang cocok
      }
    }).toList();
  }
}
