part of 'note_bloc.dart';

@immutable
abstract class NoteState {}

class NoteLoads extends NoteState {
  final dynamic list;

  NoteLoads({required this.list});

  NoteLoads copyWith({dynamic list}) {
    return NoteLoads(
      list: list ?? this.list,
    );
  }
}

class NoteFetching extends NoteState {}

class GetNote extends NoteState {
  final NoteModel note;

  GetNote({required this.note});

  GetNote copyWith({NoteModel? note}) {
    return GetNote(
      note: note ?? this.note,
    );
  }
}
