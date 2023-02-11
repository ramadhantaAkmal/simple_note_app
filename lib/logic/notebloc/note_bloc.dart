import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_note_app/db/database_provider.dart';
import 'package:simple_note_app/model/note_model.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteLoads(list: null)) {
    on<AddNote>((event, emit) {
      var noteObject = event.note;
      DatabaseProvider.db.addNewNote(noteObject);
    });

    on<ReadNote>((event, emit) async {
      GetNote noteRead = state as GetNote;
      int id = event.id;
      var note = await DatabaseProvider.db.readNote(id);
      emit(noteRead.copyWith(note: note));
    });

    on<UpdateNote>((event, emit) {
      int id = event.id;
      String title = event.title;
      String desc = event.desc;

      DatabaseProvider.db.updateNote(title, desc, id);
    });

    on<DeleteNote>((event, emit) async {
      int id = event.id;

      await DatabaseProvider.db.deleteNote(id);
    });

    on<GetNotes>((event, emit) async {
      NoteLoads noteLoads = state as NoteLoads;
      var list = await DatabaseProvider.db.getNotes();
      emit(noteLoads.copyWith(list: list));
    });
  }
}
