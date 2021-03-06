import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutterhole/constants.dart';

void showInfoSnackBar(
  BuildContext context,
  String message, {
  String title,
  Duration duration = const Duration(seconds: 5),
}) {
  Flushbar(
    title: title,
    message: message ?? 'Message',
    backgroundColor: Theme.of(context).accentColor,
    icon: Icon(
      KIcons.info,
      color: Theme.of(context).colorScheme.onPrimary,
    ),
    animationDuration: kThemeAnimationDuration,
    duration: duration,
  )..show(context);
}

void showErrorSnackBar(
  BuildContext context,
  String message, {
  String title,
  Duration duration = const Duration(seconds: 5),
}) {
  Flushbar(
    title: title,
    message: message ?? 'Message',
    icon: Icon(
      KIcons.error,
      color: KColors.error,
    ),
    animationDuration: kThemeAnimationDuration,
  )..show(context);
}
