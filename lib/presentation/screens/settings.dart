import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_pp/bussiness_logic/cubit/global_cubit.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Options"),
      ),
      body: Column(
        children: [
          SizedBox(height: 2.h),
          ListTile(
            title: const Text("Use Local Database"),
            subtitle: const Text(
              "Instead of using HTTP call to work with the app data, Please use SQLite for this",
            ),
            trailing: BlocConsumer<GlobalCubit, GlobalState>(
              builder: (context, state) {
                var cubit = GlobalCubit.get(context);
                return Switch(
                  value: cubit.isLocal,
                  onChanged: (value) {
                    cubit.changeLocal();
                  },
                );
              },
              listener: (context, state) {},
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
