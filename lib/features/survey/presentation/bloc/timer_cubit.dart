import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survey/features/survey/presentation/bloc/timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  late Timer _timer;
  final int _durationInSeconds;

  TimerCubit(this._durationInSeconds) : super(TimerInitial(_durationInSeconds));

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.remainingTime > 0) {
        emit(TimerRunInProgress(state.remainingTime - 1));
      } else {
        _timer.cancel();
        emit(TimerRunComplete());
      }
    });
  }

  void pauseTimer() {
    if (state is TimerRunInProgress) {
      _timer.cancel();
      emit(TimerRunPause(state.remainingTime));
    }
  }

  void resumeTimer() {
    if (state is TimerRunPause) {
      startTimer();
    }
  }

  void resetTimer() {
    _timer.cancel();
    emit(TimerInitial(_durationInSeconds));
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }

  String formatDuration(int durationInSeconds) {
    final Duration duration = Duration(seconds: durationInSeconds);
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes.remainder(60);
    final int seconds = duration.inSeconds.remainder(60);
    final List<String> parts = [];

    if (hours > 0) parts.add('$hours jam');
    if (minutes > 0) parts.add('$minutes menit');
    if (seconds > 0) parts.add('$seconds detik');

    return parts.join(', ');
  }
}
