import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:task_pp/bussiness_logic/cubit/global_cubit.dart';
import 'package:task_pp/data/local/cache_helper.dart';
import 'package:task_pp/presentation/screens/add_note.dart';
import 'package:task_pp/presentation/screens/add_user_screen.dart';
import 'package:task_pp/presentation/screens/settings.dart';

import '../../../core/constants.dart';
import 'list_notes_widget.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AddNote();
          }));
        },
        child: const Icon(Icons.add),
      ),
      appBar: customAppBar(context),
      body: Column(
        children: [
          BlocConsumer<GlobalCubit, GlobalState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.filter_list,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      cubit.changeShowSearch();
                    },
                    icon: const Icon(Icons.search, color: Colors.blue),
                  ),
                  cubit.isShowSearch
                      ? Expanded(
                          child: Container(
                            height: 6.h,
                            margin: EdgeInsets.all(2.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0.2.h),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 1.h, left: 3.w),
                              child: TextFormField(
                                scrollPadding: EdgeInsets.all(2.h),
                                controller: searchController,
                                onChanged: (value) {
                                  cubit.getAllNotes(value);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      searchController.text = "";
                                      cubit.getAllInterests();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                      size: 3.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              );
            },
            listener: (context, state) {},
          ),
          SizedBox(height: 1.h),
          ListNoteWidget(),
        ],
      ),
    );
  }

  AppBar customAppBar(context) {
    return AppBar(
      title: const Text("Notes"),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return AddUserScreen();
            }));
          },
          icon: const Icon(Icons.person_add),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const Setting();
            }));
          },
          icon: const Icon(Icons.settings),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.list_sharp),
        ),
      ],
    );
  }
}
