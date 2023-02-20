import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_note_app/io/note_output.dart';
import 'package:simple_note_app/logic/notebloc/note_bloc.dart';

class NoteListDrawerCard extends StatelessWidget {
  const NoteListDrawerCard({
    super.key,
    required this.notesTitle,
    required this.id,
    required this.desc,
  });

  final String notesTitle;
  final String desc;
  final int id;

  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NoteBloc>(context);
    WriteFile write = WriteFile();

    return Slidable(
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              noteBloc.add(DeleteNote(id));
              noteBloc.add(GetNotes('', ''));
            },
            backgroundColor: const Color.fromARGB(255, 138, 131, 131),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
          SlidableAction(
            onPressed: (context) {
              write.writeFile(notesTitle, desc);
            },
            backgroundColor: const Color.fromARGB(255, 138, 131, 131),
            foregroundColor: Colors.white,
            icon: Icons.download,
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          noteBloc.add(ReadNote(id));
          Navigator.pop(context);
        },
        title: Text(notesTitle),
      ),
    );
  }
}
