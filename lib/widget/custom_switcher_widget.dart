import 'package:flutter/material.dart';
import 'package:todo_list_2023/controller/switch_thememode_controller.dart';

class CustomSwitcher extends StatelessWidget {
  const CustomSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: SwitchThemeMode.instance.isDarkTheme,
      onChanged: (value) {
        SwitchThemeMode.instance.changeTheme();
      },
    );
  }
}
