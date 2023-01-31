import 'package:flutter/material.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:simple_note_app/note_list_drawer/note_list_drawer_card.dart';

class NoteListDrawer extends StatefulWidget {
  const NoteListDrawer({super.key});

  @override
  State<NoteListDrawer> createState() => _NoteListDrawerState();
}

class _NoteListDrawerState extends State<NoteListDrawer> {
  String searchValue = '';
  List<String> notesTitle = [
    'Red',
    'Blue',
    'Green',
    'Yellow',
    'Brown',
    'Purple',
    'Pink',
    'Orange',
    'Black',
    'White'
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
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
            itemCount: notesTitle.length,
            itemBuilder: ((context, index) {
              return ListCard(
                notesTitle: notesTitle,
                index: index,
              );
            }),
          ),
        ],
      ),
    );
  }
}
