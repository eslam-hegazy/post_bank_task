import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../bussiness_logic/cubit/global_cubit.dart';

class CustomDropTextField extends StatelessWidget {
  final FormFieldValidator onChanged;
  final String labelText;
  final List<String> listData;
  CustomDropTextField({
    Key? key,
    required this.onChanged,
    required this.labelText,
    required this.listData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      builder: (context, state) {
        var cubit = GlobalCubit.get(context);
        return Padding(
          padding: EdgeInsets.all(2.h),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: labelText,
              border: const OutlineInputBorder(),
            ),
            items: listData.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 20),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
