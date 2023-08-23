import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({super.key});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  // final Stream<QuerySnapshot> _stream =
  //     FirebaseFirestore.instance.collection("todo").snapshots();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String type = "";
  String category = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "New To-Do",
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                label("Task title"),
                const SizedBox(height: 12),
                titleTask(),
                const SizedBox(height: 20),
                label("Task type"),
                const SizedBox(height: 12),
                Wrap(
                  runSpacing: 15,
                  children: [
                    taskSelect("Important", 0xFFff494b),
                    const SizedBox(width: 10),
                    taskSelect("Planned", 0xFF62997a),
                    const SizedBox(width: 10),
                    taskSelect("My day", 0xFFf0a830),
                  ],
                ),
                const SizedBox(height: 20),
                label("Description"),
                const SizedBox(height: 12),
                description(),
                const SizedBox(height: 20),
                label("Task category"),
                const SizedBox(height: 12),
                Wrap(
                  runSpacing: 10,
                  children: [
                    categorySelect("Work", 0xFFbda372),
                    const SizedBox(width: 10),
                    categorySelect("Studies", 0xFF5e363f),
                    const SizedBox(width: 10),
                    categorySelect("Leizure", 0xFFE4572E),
                    const SizedBox(width: 10),
                    categorySelect("Health", 0xFF93ba85),
                    const SizedBox(width: 10),
                    categorySelect("Family", 0xFFf05d77),
                    const SizedBox(width: 10),
                    categorySelect("Essential", 0xFF78c0a8),
                  ],
                ),
                const SizedBox(height: 30),
                buttonCreateTodo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widgets

  Widget buttonCreateTodo() {
    return InkWell(
      onTap: () {
        uploadTask();
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.indigoAccent,
            ],
          ),
        ),
        child: const Center(
          child: Text(
            "Add to-do",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono',
            ),
          ),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _descriptionController,
        style: const TextStyle(
          color: Colors.black45,
          fontSize: 17,
        ),
        maxLines: null,
        expands: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Description",
          hintStyle: TextStyle(color: Colors.black45, fontSize: 17),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 10),
        ),
      ),
    );
  }

  Widget taskSelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          type = label;
        });
      },
      child: Chip(
        backgroundColor: type == label ? Colors.indigoAccent : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: type == label ? Colors.black : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        backgroundColor: category == label ? Colors.indigoAccent : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: category == label ? Colors.black : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget titleTask() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titleController,
        style: const TextStyle(
          color: Colors.black45,
          fontSize: 17,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(color: Colors.black45, fontSize: 17),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        fontFamily: 'RobotoMono',
      ),
    );
  }

  uploadTask() async {
    await FirebaseFirestore.instance.collection("todo").add({
          "title": _titleController.text,
          "task": type,
          "description": _descriptionController.text,
          "category": category
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
          content: Text('Task added successfully!'),
          backgroundColor: Colors.green,
        ));
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
  }
}
