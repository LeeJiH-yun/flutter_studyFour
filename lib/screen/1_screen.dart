import 'package:flutter/material.dart';
import 'package:flutter_studyfour/layout/default_layout.dart';
import 'package:go_router/go_router.dart';

class OneScreen extends StatelessWidget {
  const OneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: Text('뒤로가기'),
          )
        ],
      )
    );
  }
}
