import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomSheetHandleBar extends StatelessWidget {
  const BottomSheetHandleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 50,
        height: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: const Color(0xFFF1F1F1),
        ),
      ),
    );
  }
}
