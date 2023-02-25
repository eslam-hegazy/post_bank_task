import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_pp/bussiness_logic/cubit/global_cubit.dart';
import 'package:task_pp/data/models/notes_model.dart';
import 'package:task_pp/presentation/widgets/custom_drop_text_list.dart';
import 'package:task_pp/presentation/widgets/custom_text_form_field.dart';
import 'package:task_pp/presentation/widgets/custom_toast.dart';

class EditScreen extends StatelessWidget {
  EditScreen({
    Key? key,
    required this.notesModel,
  }) : super(key: key);
  final NotesModel notesModel;
  var noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    noteController.text = notesModel.text;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
        actions: [
          BlocConsumer<GlobalCubit, GlobalState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  GlobalCubit.get(context).editNote(
                    id: notesModel.id,
                    text: noteController.text,
                  );
                },
                icon: state is LoadingUpdateNoteState
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Icon(Icons.save),
              );
            },
            listener: (context, state) {
              if (state is SuccessfulUpdateNoteState) {
                Navigator.pop(context);
                customToast(state.message, Colors.grey);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          CustomTextFormField(
            controller: noteController,
            obscureText: false,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            hintText: "",
            labelText: "Note",
            maxLines: 5,
            validate: (value) {},
          ),
          CustomDropTextField(
            listData: GlobalCubit.get(context).users,
            labelText: "Assign To User",
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
