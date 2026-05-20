import 'package:flutter/material.dart';
import 'package:placement_tracker/HomePage1.dart';
import 'package:placement_tracker/Editscreen.dart';
import 'package:placement_tracker/AddScreen.dart';
import 'package:placement_tracker/widgets/unknownscreen.dart';

class FragmentHolder extends StatefulWidget {
  const FragmentHolder({super.key});

  @override
  State<FragmentHolder> createState() => _FragmentHolderState();
}

class _FragmentHolderState extends State<FragmentHolder> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/HomePage1',
      onGenerateRoute: (settings) {
        switch (settings.name) {

          case '/HomePage1':
            return MaterialPageRoute(
              builder: (context) => const HomePage1(),
            );

          case '/AddScreen':
            return MaterialPageRoute(
              builder: (context) => const AddEntryScreen(),
            );

          case '/Editscreen':
            return MaterialPageRoute(
              builder: (context) => const Editscreen(),
              settings: settings,
            );

          default:
            return MaterialPageRoute(
              builder: (context) =>  UnknownScreen(),
            );
        }
      },
    );
  }
}