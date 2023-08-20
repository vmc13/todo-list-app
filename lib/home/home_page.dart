import 'package:flutter/material.dart';
import 'package:todo_list_2023/controller/switch_thememode_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: const [
          CustomSwitcher(),
        ],
      ),
      body: const Center(
      ),
    );
  }
}

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
