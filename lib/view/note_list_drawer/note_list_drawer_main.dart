import 'package:flutter/material.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:simple_note_app/view/note_list_drawer/note_list_drawer_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/notebloc/note_bloc.dart';

class NoteListDrawer extends StatefulWidget {
  const NoteListDrawer({super.key});

  @override
  State<NoteListDrawer> createState() => _NoteListDrawerState();
}

class _NoteListDrawerState extends State<NoteListDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          TextState textState = state as TextState;
          if (textState.list == null) {
            return const Center(
              child: Text("no notes"),
            );
          }
          return Column(
            children: [
              SizedBox(
                  height: 60,
                  child: EasySearchBar(
                    onSearch: (value) {
                      BlocProvider.of<NoteBloc>(context).add(SearchNote(value));
                    },
                    title: const Text('Note List'),
                  )),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: textState.list.length,
                itemBuilder: ((context, index) {
                  return NoteListDrawerCard(
                    notesTitle: textState.list[index]['title'],
                    id: textState.list[index]['id'],
                    desc: textState.list[index]['desc'],
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
