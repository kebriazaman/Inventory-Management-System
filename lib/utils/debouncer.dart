import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  Timer? _timer;
  final int millisecs;

  Debouncer({required this.millisecs});

  void run(VoidCallback action) {
    if (_timer != null && _timer!.isActive) _timer!.cancel();
    _timer = Timer(Duration(milliseconds: millisecs), action);
  }
}
