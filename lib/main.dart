import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_pp/bussiness_logic/cubit/global_cubit.dart';
import 'package:task_pp/data/local/cache_helper.dart';
import 'package:task_pp/data/remote/dio_helper.dart';
import 'package:task_pp/presentation/screens/notes_screen/notes_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bussiness_logic/MyBlocObserver.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GlobalCubit()
              ..getAllNotes("")
              ..getAllInterests()
              ..getAllUsers(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: NotesScreen(),
        ),
      );
    });
  }
}
