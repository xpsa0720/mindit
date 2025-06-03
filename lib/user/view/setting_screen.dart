import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/user_information.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            final model = UserInformation(name: 'asdasd', sequenceDay: 3);

            await prefs.setString('userInfo', jsonEncode(model.CustomtoJson()));

            final json = await prefs.getString('userInfo');
            final asdd = jsonDecode(json!);
            print(asdd);
          },
          child: Text('1234'),
        ),
      ],
    );
  }
}
