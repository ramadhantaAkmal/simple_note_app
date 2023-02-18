import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:simple_note_app/db/database_provider.dart';
import 'package:simple_note_app/model/note_model.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(TextState(id: null, title: 'Title', desc: '')) {
    on<AddNote>((event, emit) {
      var noteObject = event.note;
      DatabaseProvider.db.addNewNote(noteObject);
    });

    on<ReadNote>((event, emit) async {
      int id = event.id;
      var note = await DatabaseProvider.db.readNote(id);
      var list = await DatabaseProvider.db.getNotes();

      emit(TextState(
          id: id, title: note[0]['title'], desc: note[0]['desc'], list: list));
    });

    on<UpdateNote>((event, emit) async {
      int id = event.id;
      String title = event.title;
      String desc = event.desc;

      await DatabaseProvider.db.updateNote(title, desc, id);
      emit(TextState(id: null));
    });

    on<DeleteNote>((event, emit) async {
      int id = event.id;

      await DatabaseProvider.db.deleteNote(id);
    });

    on<GetNotes>(
      ((event, emit) async {
        var list = await DatabaseProvider.db.getNotes();
        try {
          (event.desc == '')
              ? emit(TextState(
                  list: list,
                ))
              : emit(TextState(
                  title: event.title,
                  desc: event.desc,
                  list: list,
                ));
        } catch (e) {
          print(e);
        }
      }),
    );
  }
}
