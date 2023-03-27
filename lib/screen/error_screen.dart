import 'package:flutter/material.dart';
import 'package:flutter_studyfour/layout/default_layout.dart';

class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({required this.error, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(error),
          ElevatedButton(
            onPressed: () {},
            child: Text('홈으로'),
          )
        ],
      ),
    );
  }
}
