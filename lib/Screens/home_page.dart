import 'package:flutter/material.dart';

import 'package:notes_app/Screens/add_note.dart';
import 'package:notes_app/Screens/show_notes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 5,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNote(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "My",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      "Notes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 15,
                // ),
                // Text(
                //   "My Notes",
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 35,
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                ShowNotes(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
