import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_tracker_test/constants/colors.dart';

class CustomBadge extends StatefulWidget {
  final String title;
  final Color? backgroundColor;
  final Color? foregroundColor;
  const CustomBadge(
      {super.key,
      required this.title,
      this.backgroundColor,
      this.foregroundColor});

  @override
  State<CustomBadge> createState() => _CustomBadgeState();
}

class _CustomBadgeState extends State<CustomBadge> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.lightBlueColor),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          widget.title,
          style: GoogleFonts.inter(
              color: widget.foregroundColor ?? AppColors.badgeBlueColor,
              fontSize: 8,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
