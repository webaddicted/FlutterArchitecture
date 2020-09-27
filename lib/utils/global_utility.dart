import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

int randomNumber() {
  Random random = new Random();
  return random.nextInt(1000);
}

String formatTime(double time) {
  Duration duration = Duration(milliseconds: time.round());
  return [duration.inHours, duration.inMinutes, duration.inSeconds]
      .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
      .join(':');
}

String filesize(dynamic size, [int round = 2]) {
  int divider = 1024;
  int _size;
  try {
    _size = int.parse(size.toString());
  } catch (e) {
    throw ArgumentError("Can not parse the size parameter: $e");
  }

  if (_size < divider) {
    return "$_size B";
  }

  if (_size < divider * divider && _size % divider == 0) {
    return "${(_size / divider).toStringAsFixed(0)} KB";
  }

  if (_size < divider * divider) {
    return "${(_size / divider).toStringAsFixed(round)} KB";
  }

  if (_size < divider * divider * divider && _size % divider == 0) {
    return "${(_size / (divider * divider)).toStringAsFixed(0)} MB";
  }

  if (_size < divider * divider * divider) {
    return "${(_size / divider / divider).toStringAsFixed(round)} MB";
  }

  if (_size < divider * divider * divider * divider && _size % divider == 0) {
    return "${(_size / (divider * divider * divider)).toStringAsFixed(0)} GB";
  }

  if (_size < divider * divider * divider * divider) {
    return "${(_size / divider / divider / divider).toStringAsFixed(round)} GB";
  }

  if (_size < divider * divider * divider * divider * divider &&
      _size % divider == 0) {
    num r = _size / divider / divider / divider / divider;
    return "${r.toStringAsFixed(0)} TB";
  }

  if (_size < divider * divider * divider * divider * divider) {
    num r = _size / divider / divider / divider / divider;
    return "${r.toStringAsFixed(round)} TB";
  }

  if (_size < divider * divider * divider * divider * divider * divider &&
      _size % divider == 0) {
    num r = _size / divider / divider / divider / divider / divider;
    return "${r.toStringAsFixed(0)} PB";
  } else {
    num r = _size / divider / divider / divider / divider / divider;
    return "${r.toStringAsFixed(round)} PB";
  }
}

