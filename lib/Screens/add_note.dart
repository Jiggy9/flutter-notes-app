import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final databseRef = FirebaseDatabase.instance.ref('Notes');

  final titleController = TextEditingController();
  final messageController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    label: const Text("Title"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                      setState(() {
                        loading = true;
                      });

                      String date =
                          DateFormat('dd-MM-yyyy').format(DateTime.now());
                      String time =
                          DateFormat('hh:mm a').format(DateTime.now());

                      String idtime =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      databseRef.child(idtime.toString()).set({
                        "title": titleController.text.toString().trim(),
                        "message": messageController.text.toString().trim(),
                        "Date": date.toString(),
                        "time": time.toString(),
                        "id": idtime.toString(),
                      }).then((value) {
                        setState(() {
                          loading = false;
                        });
                        Toast.show("Note Added!!",
                            duration: Toast.lengthLong, gravity: Toast.bottom);
                        Navigator.pop(context);
                      }).onError((error, stackTrace) {
                        setState(() {
                          loading = false;
                        });
                        print(error.toString());
                      });
                    },
                    child: loading == false
                        ? const Center(
                            child: Text(
                              "Save",
                              style: TextStyle(fontSize: 25),
                            ),
                          )
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
