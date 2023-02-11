part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

class AddNote extends NoteEvent {
  final NoteModel note;

  AddNote(this.note);
}

class ReadNote extends NoteEvent {
  final int id;

  ReadNote(this.id);
}

class UpdateNote extends NoteEvent {
  final String title;
  final String desc;
  final int id;

  UpdateNote(this.title, this.desc, this.id);
}

class DeleteNote extends NoteEvent {
  final int id;

  DeleteNote(this.id);
}

class GetNotes extends NoteEvent {
  GetNotes();
}
