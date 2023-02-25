import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_pp/bussiness_logic/cubit/global_cubit.dart';
import 'package:task_pp/presentation/screens/edit_screen.dart';
import 'package:task_pp/presentation/widgets/empty_data_widget.dart';
import 'package:task_pp/presentation/widgets/error_message.dart';
import 'package:task_pp/presentation/widgets/loading_widget.dart';

import '../../../data/models/notes_model.dart';

class ListNoteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
        builder: (context, state) {
          var list = GlobalCubit.get(context).filterNotes;
          return Expanded(
            child: Column(
              children: [
                if (state is LoadingGetAllNotesState)
                  const LinearProgressIndicator(),
                if (state is ErrorGetAllNotesState) Text(state.message),
                SizedBox(height: 2.h),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        subtitle: Text(
                          list[index].text,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: CircleAvatar(
                          child: Text(list[index].id),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return EditScreen(notesModel: list[index]);
                            }));
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 3.h,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: list.length,
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
