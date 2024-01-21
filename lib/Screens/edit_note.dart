import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:toast/toast.dart';

class EditNote extends StatefulWidget {
  final String id;
  final String title;
  final String message;
  final String date;
  final String time;

  const EditNote({
    super.key,
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.time,
  });

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  var titleController = TextEditingController();
  var messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    messageController = TextEditingController(text: widget.message);
  }

  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref("Notes");
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return MaterialApp(
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    label: const Text("Tittle"),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: messageController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    label: const Text("Message"),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      setState(
                        () {
                          loading = true;
                        },
                      );

                      String date =
                          DateFormat('dd-MM-yyyy').format(DateTime.now());
                      String time =
                          DateFormat('hh:mm a').format(DateTime.now());

                      databaseRef.child(widget.id.toString()).set({
                        "title": titleController.text.toString().trim(),
                        "message": messageController.text.toString().trim(),
                        "Date": date.toString(),
                        "time": time.toString(),
                        "id": widget.id.toString(),
                      }).then(
                        (value) => {
                          setState(
                            () {
                              loading = false;
                            },
                          ),
                          Toast.show("Note Updated!!",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom),
                          Navigator.pop(context),
                          Navigator.pop(context),
                        },
                      );
                    },
                    child: loading == false
                        ? const Text("Update Now",
                            style: TextStyle(fontSize: 25))
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
