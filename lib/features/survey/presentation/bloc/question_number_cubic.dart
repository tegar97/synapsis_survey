import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionNumberCubit extends Cubit<int> {
  QuestionNumberCubit() : super(0);

  getNextQuestion() {
    emit(state + 1);
  }

  getPreviousQuestion() {
    emit(state - 1);
  }

  clearNumberQuestion() {
    emit(0);
  }
}
