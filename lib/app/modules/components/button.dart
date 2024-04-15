import 'package:flutter/material.dart';
import 'package:flutter_todo/app/modules/components/constants.dart';

button(Function() main, String title, isLoading) {
  return MaterialButton(
    onPressed: isLoading ? null : main,
    color: const Color(COL_PRIMARY),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(45),
    ),
    textColor: Colors.white,
    child: Stack(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        if (isLoading) // Show progress indicator if isLoading is true
          const Positioned.fill(
            child: LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
      ],
    ),
  );
}
