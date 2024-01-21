import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:notes_app/Screens/edit_note.dart';

class ReadingPage extends StatelessWidget {
  final String id;
  final String time;
  final String date;
  final String title;
  final String message;
  final Color color;

  const ReadingPage({
    super.key,
    required this.title,
    required this.message,
    required this.color,
    required this.id,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: color,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditNote(
                    id: id,
                    title: title,
                    message: message,
                    date: date,
                    time: time),
              ),
            );
          },
          backgroundColor: Colors.grey.shade400,
          child: const Icon(
            CupertinoIcons.pen,
            color: Colors.black,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: color,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Icon(CupertinoIcons.back),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  title.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  message.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  time.toString(),
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                Text(
                  date.toString(),
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
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
