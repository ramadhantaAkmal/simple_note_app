import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:simple_note_app/db/database_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_note_app/logic/notebloc/note_bloc.dart';
import 'package:simple_note_app/model/note_model.dart';

class NoteListDrawerCard extends StatelessWidget {
  const NoteListDrawerCard({
    super.key,
    required this.notesTitle,
    required this.id,
  });

  final String notesTitle;
  final int id;

  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NoteBloc>(context);

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
            onPressed: doNothing,
            backgroundColor: const Color.fromARGB(255, 138, 131, 131),
            foregroundColor: Colors.white,
            icon: Icons.download,
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          try {
            noteBloc.add(ReadNote(id));
          } catch (e) {
            print(e);
          }
          Navigator.pop(context);
        },
        title: Text(notesTitle),
      ),
    );
  }

  void doNothing(BuildContext context) {}
}
