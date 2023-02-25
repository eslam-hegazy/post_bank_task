import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_pp/core/strings.dart';
import 'package:task_pp/data/local/cache_helper.dart';
import 'package:task_pp/data/models/notes_model.dart';
import 'package:task_pp/data/remote/dio_helper.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());
  static GlobalCubit get(context) => BlocProvider.of(context);
  bool isShowSearch = false;
  void changeShowSearch() {
    isShowSearch = !isShowSearch;
    emit(ChangeShowSearchState());
  }

  late SharedPreferences sharedPreferences;

  //get and filter data

  List<NotesModel> filterNotes = [];

  Future<List<NotesModel>> getAllNotes(String? text) async {
    List<NotesModel> notes = [];
    emit(LoadingGetAllNotesState());
    await DioHelper.getData(url: "/notes/getall").then(
      (value) {
        value.data.forEach((e) {
          notes.add(NotesModel.fromJson(e));
        });

        CacheHelper.cacheNotes(notes).then((value) {
          emit(SuccessfulGetAllNotesState(message: "Get Notes Successful"));
        });
      },
    ).catchError(
      (error) {
        emit(ErrorGetAllNotesState(message: ""));
      },
    );

    return getFilterData(notes, text!);
  }

  //filter Data
  List<NotesModel> getFilterData(List<NotesModel> notes, String text) {
    filterNotes = [];

    filterNotes.addAll(notes);
    filterNotes.retainWhere((element) {
      return element.text.toLowerCase().contains(text.toLowerCase());
    });
    return filterNotes;
  }

  ///change visible
  bool isVisible = false;
  void changeVisible() {
    isVisible = !isVisible;
    emit(ChangeVisible(message: "Change"));
  }

  String dropValue = "eslam";
  void changeDropValue(String value) {
    dropValue = value;
    emit(ChangeDropValueState());
  }

  ///get Interests
  List<String> intrests = [];
  Future<void> getAllInterests() async {
    intrests = [];
    emit(LoadingInterestsState());
    await DioHelper.getData(url: "/intrests/getall").then((value) {
      value.data.forEach((e) {
        intrests.add(e['intrestText']);
      });
      emit(SuccessfulInterestsState(message: "Successful Get Data"));
    }).catchError((error) {
      print(error);
      emit(ErrorInterestsState(message: "Error Get Data"));
    });
  }

  //Insert User
  void insertUser(
      {required String userName,
      required String password,
      required String email}) async {
    emit(LoadingInsertUserState());
    await DioHelper.postData(
      url: "/users/insert",
      body: {
        "Username": userName,
        "Password": password,
        "Email": email,
      },
    ).then((value) {
      emit(SuccessfulInsertUserState(message: value.data));
      print(value);
    }).catchError((error) {
      emit(ErrorInsertUserState(message: "Please Check Your Internet"));
      print(error);
    });
  }

  ///Get All Users
  List<String> users = [];
  void getAllUsers() async {
    users = [];
    emit(LoadingGetUsersState());
    await DioHelper.getData(url: "/users/getall").then((value) {
      print("get users");
      value.data.forEach((e) {
        users.add(e["username"]);
      });
      emit(SuccessfulGetUsersState());
    }).catchError((error) {
      print(error);
      emit(ErrorGetUsersState());
    });
  }

  ///Edit Note
  void editNote({required String id, required String text, required}) async {
    emit(LoadingUpdateNoteState());
    await DioHelper.postData(url: "/notes/update", body: {
      "Id": id,
      "Text": text,
    }).then((value) {
      emit(SuccessfulUpdateNoteState(message: value.data));
      print(value);
    }).catchError((error) {
      print(error);
      emit(ErrorUpdateNoteState(message: "Check Your Internet"));
    });
  }

  /// change Database Storage
  bool isLocal = false;
  void changeLocal() {
    isLocal = !isLocal;
    CacheHelper.saveDataSharedPreference(key: ISCONNECT, value: isLocal)
        .then((value) {
      emit(ChangeLocalState());
    });
  }

  ///Add Note
  void addNote({
    required String text,
    required String userId,
    required String placeDateTime,
  }) async {
    emit(LoadingInsertNoteState());
    await DioHelper.postData(url: "/notes/insert", body: {}).then((value) {
      emit(SuccessfulInsertNoteState(message: value.data));
    }).catchError((error) {
      emit(ErrorInsertNoteState(message: "Error Insert"));
      print(error);
    });
  }
}
