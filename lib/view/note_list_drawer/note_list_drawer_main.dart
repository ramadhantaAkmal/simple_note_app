import 'package:flutter/material.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:simple_note_app/db/database_provider.dart';
import 'package:simple_note_app/view/note_list_drawer/note_list_drawer_card.dart';

class NoteListDrawer extends StatefulWidget {
  const NoteListDrawer({super.key});

  @override
  State<NoteListDrawer> createState() => _NoteListDrawerState();
}

class _NoteListDrawerState extends State<NoteListDrawer> {
  String searchValue = '';

  getNotes() async {
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<dynamic>(
        future: getNotes(),
        builder: (context, noteData) {
          final notes = noteData.data;
          switch (noteData.connectionState) {
            case ConnectionState.waiting:
              {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            case ConnectionState.done:
              {
                if (notes == Null) {
                  return const Center(
                    child: Text("Uhh non"),
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: 60,
                        child: EasySearchBar(
                          onSearch: (value) =>
                              setState(() => searchValue = value),
                          title: const Text('Note List'),
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: notes.length,
                        itemBuilder: ((context, index) {
                          return listCard(
                            notesTitle: notes[index]['title'],
                            index: index,
                            id: notes[index]['id'],
                            func: () {
                              setState(() {});
                            },
                            context: context,
                          );
                        }),
                      ),
                    ],
                  );
                }
              }
            case ConnectionState.none:
              return const SizedBox(
                width: 1,
              );
            case ConnectionState.active:
              return const SizedBox(
                width: 1,
              );
          }
        },
      ),
    );
  }
}
