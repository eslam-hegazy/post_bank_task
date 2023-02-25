import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_pp/core/constants.dart';

import '../models/notes_model.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getDataFromSharedPreference({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<Unit> cacheNotes(List<NotesModel> noteModel) {
    List postModelToJson =
        noteModel.map<Map<String, dynamic>>((e) => e.toJson()).toList();
    sharedPreferences.setString(CACHE_NOTES, json.encode(postModelToJson));
    return Future.value(unit);
  }

  static List<NotesModel> getAllNotes() {
    final getCachedNotes = sharedPreferences.getString(CACHE_NOTES);
    List decodeJsonDate = json.decode(getCachedNotes!);
    List<NotesModel> notes =
        decodeJsonDate.map<NotesModel>((e) => NotesModel.fromJson(e)).toList();
    return notes;
  }

  static Future<bool> saveDataSharedPreference(
      {required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }
}
