import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:simple_note_app/db/database_provider.dart';

Widget listCard(
    {required dynamic notesTitle,
    required int index,
    required int id,
    required VoidCallback func,
    required BuildContext context}) {
  return Slidable(
    startActionPane: ActionPane(
      motion: const BehindMotion(),
      children: [
        SlidableAction(
          onPressed: ((context) {
            DatabaseProvider.db.deleteNote(id);
            func();
          }),
          backgroundColor: const Color.fromARGB(255, 138, 131, 131),
          foregroundColor: Colors.white,
          icon: Icons.delete,
        ),
        const SlidableAction(
          onPressed: doNothing,
          backgroundColor: Color.fromARGB(255, 138, 131, 131),
          foregroundColor: Colors.white,
          icon: Icons.download,
        ),
      ],
    ),
    child: ListTile(
      onTap: () {
        Navigator.of(context).pop();
      },
      title: Text(notesTitle),
    ),
  );
}

void doNothing(BuildContext context) {}
