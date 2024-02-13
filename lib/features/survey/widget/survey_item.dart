import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:svg_flutter/svg.dart';
import 'package:synapsis_survey/common/app_route.dart';
import 'package:synapsis_survey/common/formatter.dart';
import 'package:synapsis_survey/common/theme.dart';
import 'package:synapsis_survey/features/survey/domain/entities/survey_entity.dart';

class Surveyitem extends StatelessWidget {
  const Surveyitem({super.key, required this.survey});

  final SurveyEntity survey;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.pushNamed(context, AppRoute.surveyQuestion,
            arguments: survey.id)
      },
      borderRadius: BorderRadius.circular(4),
      child: Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(width: 1, color: Color(0xffD9D9D9))),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              SvgPicture.asset("assets/ph_exam.svg"),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(survey.name,
                          style: bodyTextStyle.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                      const SizedBox(height: 8),
                      Text("Created At: ${formatDateString(survey.createdAt)}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff107C41),
                          )),
                      Text(
                        "Last download At: ${survey.downloadedAt != '' ? formatDateString(survey.downloadedAt) : 'Not downloaded'}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff107C41),
                        ),
                      )
                    ]),
              )
            ],
          )),
    );
  }
}
