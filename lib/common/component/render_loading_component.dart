import 'package:flutter/material.dart';

class RenderLoadingComponent extends StatelessWidget {
  const RenderLoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(color: Colors.black),
      ),
    );
  }
}
