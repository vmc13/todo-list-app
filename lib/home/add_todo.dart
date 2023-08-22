import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({super.key});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String type = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "New To-Do",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                label("Task title"),
                const SizedBox(height: 12),
                titleTask(),
                const SizedBox(height: 30),
                label("Task type"),
                const SizedBox(height: 12),
                Wrap(
                  runSpacing: 15,
                  children: [
                    taskSelect("Important", 0xFFE4572E),
                    const SizedBox(width: 20),
                    taskSelect("Planned", 0xFF7CDEDC),
                    const SizedBox(width: 20),
                    taskSelect("My day", 0xFFDE89BE),
                  ],
                ),
                const SizedBox(height: 25),
                label("Description"),
                const SizedBox(height: 12),
                description(),
                const SizedBox(height: 50),
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
      onTap: () async {
        await FirebaseFirestore.instance.collection("todo").add({
          "title": _titleController.text,
          "task": type,
          "Description": _descriptionController.text
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
          content: Text('Task added successfully!'),
          backgroundColor: Colors.green,
        ));
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF9C27B0),
              Color.fromARGB(255, 124, 17, 143),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            "Add To-Do",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'RobotoMono',
            ),
          ),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 150,
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
}
