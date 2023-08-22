import 'package:flutter/material.dart';
import 'package:todo_list_2023/home/add_todo.dart';
import 'package:todo_list_2023/widget/todo_card_widget.dart';

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
          "Today's Schedule",
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          SizedBox(
            height: 50,
            child: CircleAvatar(
              backgroundImage:
                  AssetImage("assets/images/home_profile_avatar.png"),
            ),
          ),
          SizedBox(width: 25),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(35),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 75),
              child: Text(
                "Thursday 22",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 30,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => const AddToDo(),
                ),
              );
            },
            child: Container(
              height: 52,
              width: 52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.indigoAccent,
                    Colors.purple,
                  ],
                ),
              ),
              child: const Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            size: 30,
          ),
          label: '',
        ),
      ]),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                TodoCard(
                  title: "Wake up",
                  iconData: Icons.alarm,
                  iconColor: Colors.red,
                  time: "7 AM",
                  check: true,
                  iconBgColor: Colors.white,
                ),
                SizedBox(height: 10),
                TodoCard(
                  title: "Go to the gym",
                  iconData: Icons.run_circle_outlined,
                  iconColor: Colors.green,
                  time: "8 AM",
                  check: true,
                  iconBgColor: Colors.white,
                ),
                SizedBox(height: 10),
                TodoCard(
                  title: "Buy food",
                  iconData: Icons.local_grocery_store,
                  iconColor: Colors.orange,
                  time: "9 AM",
                  check: true,
                  iconBgColor: Colors.white,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
