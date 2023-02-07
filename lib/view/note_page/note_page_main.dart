import 'package:flutter/material.dart';
import 'package:simple_note_app/constant.dart';
import 'package:simple_note_app/db/database_provider.dart';
import 'package:simple_note_app/model/note_model.dart';
import 'package:simple_note_app/view/note_list_drawer/note_list_drawer_main.dart';

class NotePageMain extends StatefulWidget {
  NotePageMain({super.key});

  @override
  State<NotePageMain> createState() => _NotePageMainState();
}

class _NotePageMainState extends State<NotePageMain> {
  String title = "null";
  String desc = "null";

  final TextEditingController _title = TextEditingController(text: "Title");
  final TextEditingController _desc = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  getNote(int id) async {
    var note = DatabaseProvider.db.readNote(id);
    return note;
  }

  addNote(NoteModel note) {
    DatabaseProvider.db.addNewNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: const NoteListDrawer(),
        appBar: _buildAppBar(),
        body: _buildBody(context),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: TextField(
        cursorColor: bodyTextColor,
        controller: _title,
        showCursor: true,
        decoration: const InputDecoration(
          hintText: "Enter Title",
          border: InputBorder.none,
        ),
      ),
      centerTitle: true,
      leading: Center(
        child: IconButton(
            onPressed: () {
              _key.currentState?.openDrawer();
            },
            icon: const Icon(
              Icons.folder,
              color: bodyTextColor,
            )),
      ),
      actions: <Widget>[
        Center(
          child: IconButton(
              onPressed: () {
                setState(() {
                  title = _title.text;
                  desc = _desc.text;
                  _title.text = "";
                  _desc.text = "";
                });
                addNote(NoteModel(title: title, desc: desc));
              },
              icon: const Icon(
                Icons.save,
                color: bodyTextColor,
              )),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        child: TextField(
          cursorColor: bodyTextColor,
          controller: _desc,
          showCursor: true,
          decoration: const InputDecoration(
            hintText: "Enter Description",
            hintStyle: TextStyle(
              color: bodyTextColor,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          expands: true,
          maxLines: null,
          minLines: null,
        ),
      ),
    );
  }
}
