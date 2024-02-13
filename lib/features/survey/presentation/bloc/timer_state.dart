

import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  final int remainingTime;

  const TimerState(this.remainingTime);

  @override
  List<Object> get props => [remainingTime];
}

class TimerInitial extends TimerState {
  const TimerInitial(int durationInSeconds) : super(durationInSeconds);
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(int remainingTime) : super(remainingTime);
}

class TimerRunPause extends TimerState {
  const TimerRunPause(int remainingTime) : super(remainingTime);
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}
