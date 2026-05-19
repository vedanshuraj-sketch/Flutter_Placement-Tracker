import 'package:flutter/material.dart';
import 'package:placement_tracker/HomePage1.dart';
import 'package:placement_tracker/widgets/test1.dart';
import 'package:placement_tracker/widgets/test2.dart';
import 'package:placement_tracker/widgets/unknownscreen.dart';

class FragmentHolder extends StatefulWidget {
  @override
  _FragmentHolderState createState() => _FragmentHolderState();
}

class _FragmentHolderState extends State<FragmentHolder> {

  final List<String> strings = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/HomePage1',

      onGenerateRoute: (settings) {
        switch (settings.name) {

          case '/HomePage1':
            return MaterialPageRoute(
              builder: (context) => HomePage1(),
            );

          case '/test1':
            return MaterialPageRoute(
              builder: (context) => Test1(),
            );
          case '/test2':
            return MaterialPageRoute(
              builder: (context) => Test2(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => UnknownScreen(),
            );
        }
      },
    );
  }
}