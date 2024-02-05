import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object> get props => [];
}

class TimerInitial extends TimerState {}

class TimerRunning extends TimerState {
  final Duration duration;

  const TimerRunning(this.duration);
}

class TimerPaused extends TimerState {
  final Duration duration;

  const TimerPaused(this.duration);

  @override
  List<Object> get props => [duration];
}
