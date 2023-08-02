import 'package:flutter/material.dart';

enum AuthWidgetState { register, login ,registerAndLogin }

class WidgetWithAuthPageState {
  final Widget child;
  final AuthWidgetState authState;

  WidgetWithAuthPageState({required this.child, required this.authState});
}
