import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:toast/toast.dart';

import 'reading_note.dart';

class ShowNotes extends StatefulWidget {
  const ShowNotes({super.key});

  @override
  State<ShowNotes> createState() => _ShowNotesState();
}

final databaseref = FirebaseDatabase.instance.ref("Notes");
final List<Color> colorlist = [
  Colors.greenAccent,
  Colors.orangeAccent,
  Colors.yellow,
  Colors.lightBlueAccent,
  Colors.pinkAccent,
  Colors.purpleAccent,
  Colors.tealAccent,
  Colors.redAccent,
  Colors.indigoAccent,
  Colors.deepOrangeAccent,
];

class _ShowNotesState extends State<ShowNotes> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Expanded(
      child: StreamBuilder(
        stream: databaseref.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            Map<dynamic, dynamic>? map =
                (snapshot.data!.snapshot.value as Map<dynamic, dynamic>?) ?? {};
            List<dynamic> list = map.values.toList();

            if (list.isEmpty) {
              return const Center(
                child: Text(
                  'No notes here',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            }

            return MasonryGridView.count(
              mainAxisSpacing: 15,
              crossAxisSpacing: 12,
              itemCount: snapshot.data!.snapshot.children.length,
              crossAxisCount: 2,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReadingPage(
                          title: list[index]['title'].toString(),
                          message: list[index]['message'].toString(),
                          date: list[index]['Date'],
                          time: list[index]['time'],
                          id: list[index]['id'].toString(),
                          color: colorlist[index % colorlist.length],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: colorlist[index % colorlist.length],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              list[index]['title'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              list[index]['message'],
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 25),
                            Align(
                              alignment: Alignment.topRight,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      databaseref
                                          .child(list[index]['id'].toString())
                                          .remove()
                                          .then(
                                        (value) {
                                          Toast.show("Note Deleted!!",
                                              duration: Toast.lengthLong,
                                              gravity: Toast.bottom);
                                        },
                                      ).onError(
                                        (error, stackTrace) {
                                          Toast.show(error.toString(),
                                              duration: Toast.lengthLong,
                                              gravity: Toast.bottom);
                                        },
                                      );
                                    },
                                    child: const Icon(
                                      (Icons.delete),
                                      color: Colors.black38,
                                    ),
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        list[index]['time'].toString(),
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        list[index]['Date'].toString(),
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
