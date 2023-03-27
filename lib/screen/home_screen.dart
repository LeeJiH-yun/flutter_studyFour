import 'package:flutter/material.dart';
import 'package:flutter_studyfour/layout/default_layout.dart';
import 'package:flutter_studyfour/screen/3_screen.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              context.go('/one');
            },
            child: Text('Screen one'),
          ),
          ElevatedButton(
            onPressed: () {
              context.goNamed(ThreeScreen.routeName);
            },
            child: Text('Screen one/two/three'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/login');
            },
            child: Text('loginScreen'),
          )
        ],
      ),
    );
  }
}