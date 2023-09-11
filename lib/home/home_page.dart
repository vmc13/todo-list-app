import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_2023/home/add_todo.dart';
import 'package:todo_list_2023/home/view_task_data.dart';
import 'package:todo_list_2023/widget/todo_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("todo").snapshots();

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
                    color: Colors.deepPurpleAccent,
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
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              late IconData iconData;
              late Color iconColor;
              Map<String, dynamic> document =
                  snapshot.data?.docs[index].data() as Map<String, dynamic>;

              switch (document["category"]) {
                case "Work":
                  iconData = Icons.work;
                  iconColor = const Color(0xFFbda372);
                  break;
                case "Studies":
                  iconData = Icons.menu_book_rounded;
                  iconColor = const Color(0xFF5e363f);
                  break;
                case "Leizure":
                  iconData = Icons.beach_access_rounded;
                  iconColor = const Color(0xFFE4572E);
                  break;
                case "Health":
                  iconData = Icons.local_hospital_rounded;
                  iconColor = const Color(0xFF93ba85);
                  break;
                case "Family":
                  iconData = Icons.family_restroom;
                  iconColor = const Color(0xFFf05d77);
                  break;
                case "Essential":
                  iconData = Icons.home;
                  iconColor = const Color(0xFF78c0a8);
                  break;
                default:
                  iconData = Icons.question_mark_rounded;
                  iconColor = const Color(0xFF93ba85);
              }
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => ViewTaskData(
                        document: document,
                        id: snapshot.data!.docs[index].id,
                      ),
                    ),
                  );
                },
                child: TodoCard(
                  title: document["title"],
                  iconData: iconData,
                  iconColor: iconColor,
                  check: true,
                  iconBgColor: Colors.white,
                  time: "7 AM",
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: const Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 20,
//             ),
//             child: Column(
//               children: [
//               ],
//             ),
//           ),
//         ),