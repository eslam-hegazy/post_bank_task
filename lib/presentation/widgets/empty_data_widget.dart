import 'package:flutter/material.dart';

import 'package:task_pp/core/strings.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text(EMPTY_DATA),
      ),
    );
  }
}
