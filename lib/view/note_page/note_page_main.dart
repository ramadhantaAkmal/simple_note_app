import 'package:flutter/material.dart';
import 'package:simple_note_app/constant.dart';
import 'package:simple_note_app/model/note_model.dart';
import 'package:simple_note_app/view/note_list_drawer/note_list_drawer_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_note_app/db/database_provider.dart';

import '../../logic/notebloc/note_bloc.dart';

class NotePageMain extends StatefulWidget {
  const NotePageMain({super.key});

  @override
  State<NotePageMain> createState() => _NotePageMainState();
}

class _NotePageMainState extends State<NotePageMain> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String title = 'null', desc = 'null';

  bool isEdited = false, onUpdate = true;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        TextState textState = state as TextState;

        if (onUpdate) {
          isEdited = false;
        }

        if (textState.id != null && isEdited == false) {
          titleController.text = textState.title!;
          descController.text = textState.desc!;
        }
        return SafeArea(
            child: Scaffold(
          key: _key,
          drawer: const NoteListDrawer(),
          appBar: buildAppBar(context, textState, titleController),
          body: buildBody(context, descController),
        ));
      },
    );
  }

  AppBar buildAppBar(BuildContext context, TextState state,
      TextEditingController titleController) {
    var noteBlock = BlocProvider.of<NoteBloc>(context);

    return AppBar(
      title: TextFormField(
        cursorColor: bodyTextColor,
        controller: titleController,
        showCursor: true,
        decoration: const InputDecoration(
          hintText: "Enter Title",
          border: InputBorder.none,
        ),
        onChanged: (value) {
          isEdited = true;
          onUpdate = false;
        },
      ),
      centerTitle: true,
      leading: Center(
        child: IconButton(
            onPressed: () {
              noteBlock
                  .add(GetNotes(titleController.text, descController.text));
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
                if (state.id == null) {
                  if ((titleController.text.isNotEmpty ||
                      descController.text.isNotEmpty)) {
                    title = titleController.text;
                    desc = descController.text;
                    titleController.clear();
                    descController.clear();
                    noteBlock.add(GetNotes(title, desc));
                    noteBlock.add(AddNote(NoteModel(title: title, desc: desc)));
                  }
                } else {
                  title = titleController.text;
                  desc = descController.text;
                  titleController.clear();
                  descController.clear();
                  noteBlock.add(UpdateNote(title, desc, state.id!));
                  onUpdate = true;
                }
              },
              icon: const Icon(
                Icons.save,
                color: bodyTextColor,
              )),
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context, TextEditingController descontroller) {
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
          controller: descController,
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
          onChanged: (value) {
            isEdited = true;
            onUpdate = false;
          },
          expands: true,
          maxLines: null,
          minLines: null,
        ),
      ),
    );
  }
}
