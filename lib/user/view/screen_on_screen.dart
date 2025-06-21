import 'package:flutter/material.dart';

class ScreenOnScreen extends StatefulWidget {
  const ScreenOnScreen({super.key});

  @override
  State<ScreenOnScreen> createState() => _ScreenOnScreenState();
}

class _ScreenOnScreenState extends State<ScreenOnScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("굳잡")));
  }
}
