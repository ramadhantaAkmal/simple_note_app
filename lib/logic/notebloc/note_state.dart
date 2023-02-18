part of 'note_bloc.dart';

@immutable
abstract class NoteState {}

class NoteInitial extends NoteState {
  NoteInitial();
}

class TextState extends NoteState {
  final int? id;
  final String? title;
  final String? desc;
  final dynamic list;

  TextState({
    this.id,
    this.title,
    this.desc,
    this.list,
  });
}
