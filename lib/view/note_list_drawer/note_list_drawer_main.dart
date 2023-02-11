import 'package:flutter/material.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:simple_note_app/db/database_provider.dart';
import 'package:simple_note_app/view/note_list_drawer/note_list_drawer_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/notebloc/note_bloc.dart';

class NoteListDrawer extends StatefulWidget {
  const NoteListDrawer({super.key});

  @override
  State<NoteListDrawer> createState() => _NoteListDrawerState();
}

class _NoteListDrawerState extends State<NoteListDrawer> {
  String searchValue = '';

  // getNotes() async {
  //   final notes = await DatabaseProvider.db.getNotes();
  //   return notes;
  // }

  @override
  Widget build(BuildContext context) {
    NoteBloc noteBloc = BlocProvider.of<NoteBloc>(context);
    return Drawer(
      child: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteFetching) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var list = (state as NoteLoads).list;

          if (list == null) {
            return const Center(
              child: Text("uhh non"),
            );
          }

          return Column(
            children: [
              SizedBox(
                height: 60,
                child: EasySearchBar(
                  onSearch: (value) => setState(() => searchValue = value),
                  title: const Text('Note List'),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: list.length,
                itemBuilder: ((context, index) {
                  return NoteListDrawerCard(
                    notesTitle: list[index]['title'],
                    index: index,
                    id: list[index]['id'],
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
