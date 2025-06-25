import 'package:flutter/material.dart';
import 'package:mindit/common/component/text_component.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  static String get routeFullPath => '/error';
  static String get routePath => 'error';
  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: TextComponent(text: '에러가 났습니다')));
  }
}
