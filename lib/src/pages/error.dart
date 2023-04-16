import 'dart:developer';

import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final Object e;
  final StackTrace? trace;

  const ErrorScreen(
    this.e,
    this.trace, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            e.toString(),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            trace.toString(),
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

