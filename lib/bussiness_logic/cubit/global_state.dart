part of 'global_cubit.dart';

abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class LoadingGetAllNotesState extends GlobalState {}

class SuccessfulGetAllNotesState extends GlobalState {
  final String message;
  SuccessfulGetAllNotesState({
    required this.message,
  });
}

class ErrorGetAllNotesState extends GlobalState {
  final String message;
  ErrorGetAllNotesState({
    required this.message,
  });
}

class ChangeVisible extends GlobalState {
  final String message;
  ChangeVisible({
    required this.message,
  });
}

class ChangeDropValueState extends GlobalState {}

class LoadingInterestsState extends GlobalState {}

class SuccessfulInterestsState extends GlobalState {
  final String message;
  SuccessfulInterestsState({
    required this.message,
  });
}

class ErrorInterestsState extends GlobalState {
  final String message;
  ErrorInterestsState({
    required this.message,
  });
}

class LoadingInsertUserState extends GlobalState {}

class SuccessfulInsertUserState extends GlobalState {
  final String message;
  SuccessfulInsertUserState({
    required this.message,
  });
}

class ErrorInsertUserState extends GlobalState {
  final String message;
  ErrorInsertUserState({
    required this.message,
  });
}

class ChangeShowSearchState extends GlobalState {}

class LoadingGetUsersState extends GlobalState {}

class SuccessfulGetUsersState extends GlobalState {}

class ErrorGetUsersState extends GlobalState {}

class LoadingUpdateNoteState extends GlobalState {}

class SuccessfulUpdateNoteState extends GlobalState {
  final String message;
  SuccessfulUpdateNoteState({
    required this.message,
  });
}

class ErrorUpdateNoteState extends GlobalState {
  final String message;
  ErrorUpdateNoteState({
    required this.message,
  });
}

class ChangeLocalState extends GlobalState {}

class LoadingInsertNoteState extends GlobalState {}

class SuccessfulInsertNoteState extends GlobalState {
  final String message;
  SuccessfulInsertNoteState({
    required this.message,
  });
}

class ErrorInsertNoteState extends GlobalState {
  final String message;
  ErrorInsertNoteState({
    required this.message,
  });
}
