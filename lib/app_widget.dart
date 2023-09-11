import 'package:flutter/material.dart';
import 'package:todo_list_2023/controller/switch_thememode_controller.dart';
import 'package:todo_list_2023/home/home_page.dart';
// import 'package:todo_list_2023/home/login_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: SwitchThemeMode.instance,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            useMaterial3: true,
            brightness: SwitchThemeMode.instance.isDarkTheme
                ? Brightness.dark
                : Brightness.light,
          ),
          debugShowCheckedModeBanner: false,
          home:  const HomePage(),
        );
      },
    );
  }
}
