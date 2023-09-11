import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewTaskData extends StatefulWidget {
  const ViewTaskData({super.key, required this.document, required this.id});

  final Map<String, dynamic> document;
  final String id;

  @override
  State<ViewTaskData> createState() => _ViewTaskDataState();
}

class _ViewTaskDataState extends State<ViewTaskData> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String type;
  late String category;
  bool edit = false;

  @override
  void initState() {
    super.initState();
    String title = widget.document['title'] ?? "Hey there";
    _titleController = TextEditingController(text: title);
    _descriptionController =
        TextEditingController(text: widget.document['description']);
    type = widget.document['task'];
    category = widget.document['category'];
  }

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
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.deepPurple,
                        size: 28,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection("todo")
                                .doc(widget.id)
                                .delete()
                                .then((value) => {
                                  Navigator.pop(context)
                                });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.deepPurple,
                            size: 28,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              edit = !edit;
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: edit ? Colors.green : Colors.deepPurple,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  edit ? "Editing" : "View",
                  style: const TextStyle(
                    fontSize: 28,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Tour To-Do",
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
                  runSpacing: 10,
                  children: [
                    taskSelect("Important", edit ? 0xFFff494b : 0xFF9E9E9E),
                    const SizedBox(width: 10),
                    taskSelect("Planned", edit ? 0xFF62997a : 0xFF9E9E9E),
                    const SizedBox(width: 10),
                    taskSelect("My day", edit ? 0xFFf0a830 : 0xFF9E9E9E),
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
                    categorySelect("Work", edit ? 0xFFbda372 : 0xFF9E9E9E),
                    const SizedBox(width: 10),
                    categorySelect("Studies", edit ? 0xFF5e363f : 0xFF9E9E9E),
                    const SizedBox(width: 10),
                    categorySelect("Leizure", edit ? 0xFFE4572E : 0xFF9E9E9E),
                    const SizedBox(width: 10),
                    categorySelect("Health", edit ? 0xFF93ba85 : 0xFF9E9E9E),
                    const SizedBox(width: 10),
                    categorySelect("Family", edit ? 0xFFf05d77 : 0xFF9E9E9E),
                    const SizedBox(width: 10),
                    categorySelect("Essential", edit ? 0xFF78c0a8 : 0xFF9E9E9E),
                  ],
                ),
                const SizedBox(height: 40),
                edit ? buttonCreateTodo() : Container(),
                const SizedBox(height: 30),
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
            "Update to-do",
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
        enabled: edit,
        style: TextStyle(
          color: edit ? Colors.black54 : Colors.black,
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
      onTap: edit
          ? () {
              setState(() {
                type = label;
              });
            }
          : null,
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
      onTap: edit
          ? () {
              setState(() {
                category = label;
              });
            }
          : null,
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
        enabled: edit,
        style: TextStyle(
          color: edit ? Colors.black54 : Colors.black,
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
    await FirebaseFirestore.instance.collection("todo").doc(widget.id).update({
      "title": _titleController.text,
      "task": type,
      "description": _descriptionController.text,
      "category": category
    });
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Task uploaded successfully!'),
      backgroundColor: Colors.green,
    ));
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
