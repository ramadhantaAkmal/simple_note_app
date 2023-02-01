import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListCard extends StatelessWidget {
  const ListCard({super.key, required this.notesTitle, required this.index});
  final List<String> notesTitle;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: const ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color.fromARGB(255, 138, 131, 131),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color.fromARGB(255, 138, 131, 131),
            foregroundColor: Colors.white,
            icon: Icons.download,
          ),
        ],
      ),
      child: ListTile(
        title: Text(notesTitle[index]),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
