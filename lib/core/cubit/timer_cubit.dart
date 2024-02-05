import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:time_tracker_test/core/cubit/timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  late Timer _timer;
  late Duration _duration;
  final _durationController = StreamController<Duration>();

  TimerCubit() : super(TimerInitial());

  Stream<Duration> get timerStream => _durationController.stream;

  void startTimer() {
    if (state is TimerInitial || state is TimerPaused) {
      _duration = (state is TimerPaused)
          ? (state as TimerPaused).duration
          : const Duration();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _duration += const Duration(seconds: 1);
        _durationController.add(_duration);
        emit(TimerRunning(_duration));
      });
    }
  }

  void pauseTimer() {
    _timer.cancel();
    _durationController.add(_duration);
    emit(TimerPaused(_duration));
  }

  void resumeTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _duration += const Duration(seconds: 1);
      _durationController.add(_duration);
      emit(TimerRunning(_duration));
    });
  }

  void stopTimer() {
    _timer.cancel();
    _durationController.add(Duration.zero);
    emit(TimerInitial());
  }

  @override
  Future<void> close() {
    _timer.cancel();
    _durationController.close();
    return super.close();
  }

  Duration getCurrentDuration() {
    if (state is TimerRunning || state is TimerPaused) {
      return (state as TimerRunning).duration;
    } else {
      return Duration.zero;
    }
  }
}
