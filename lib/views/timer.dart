import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_tracker_test/constants/colors.dart';
import 'package:time_tracker_test/core/cubit/timer_cubit.dart';
import 'package:time_tracker_test/core/cubit/timer_state.dart';
import 'package:time_tracker_test/widgets/badge.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late TimerCubit timerCubit;

  @override
  void initState() {
    super.initState();
    timerCubit = TimerCubit();
  }

  @override
  void dispose() {
    timerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppColors.containerBackgroundColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Monday, Feburuary 05",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700, fontSize: 12),
                            ),
                            const Gap(20),
                            StreamBuilder<Duration>(
                              stream: context.read<TimerCubit>().timerStream,
                              initialData: Duration.zero,
                              builder: (context, snapshot) {
                                final duration = snapshot.data;
                                return Text(
                                  _formatDuration(duration),
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.blue.shade800,
                                  ),
                                );
                              },
                            ),
                            const Gap(20),
                            Text(
                              "Growth Team",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            const Gap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const CustomBadge(
                                  title: "ME-3676",
                                ),
                                const Gap(10),
                                Text(
                                  "Activate P2U",
                                  style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            const Gap(30),
                            BlocConsumer<TimerCubit, TimerState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return InkWell(
                                  onTap: () {
                                    if (state is TimerInitial) {
                                      context.read<TimerCubit>().startTimer();
                                    } else if (state is TimerRunning) {
                                      context.read<TimerCubit>().pauseTimer();
                                    } else if (state is TimerPaused) {
                                      context.read<TimerCubit>().resumeTimer();
                                    } else {
                                      context.read<TimerCubit>().stopTimer();
                                    }
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.lightBlueColor,
                                    child: BlocBuilder<TimerCubit, TimerState>(
                                      builder: (context, state) {
                                        if (state is TimerRunning) {
                                          return const Icon(Icons.pause);
                                        } else {
                                          return const Icon(Icons.play_arrow);
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            const Gap(30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomBadge(
                                  title:
                                      "Daily Working hours \nlimited to 9 hours",
                                  backgroundColor: AppColors.lightGreenColor,
                                  foregroundColor: AppColors.greenColor,
                                ),
                                Container(
                                  width: 0.7,
                                  height: 20,
                                  color: Colors.black,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total",
                                          style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const Gap(5),
                                        Text(
                                          "Not Included",
                                          style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const Gap(5),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        CustomBadge(title: "3:18:43"),
                                        Gap(5),
                                        CustomBadge(
                                          title: "-30:40",
                                          backgroundColor:
                                              AppColors.lightRedColor,
                                          foregroundColor: AppColors.redColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  String _formatDuration(Duration? duration) {
    if (duration != null) {
      final hours = duration.inHours;
      final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
      final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
      return '$hours:$minutes:$seconds Hours';
    } else {
      return '00:00:00 Hours';
    }
  }
}
