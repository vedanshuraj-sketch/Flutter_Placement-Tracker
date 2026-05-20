import 'package:flutter/material.dart';
import 'package:placement_tracker/HomePage1.dart';
import 'package:placement_tracker/widgets/test1.dart';
import 'package:placement_tracker/widgets/test2.dart';
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
              builder: (context) => HomePage1(),
            );

          case '/test1':

            return MaterialPageRoute(
              builder: (context) => Test1(
                title: 'Software Engineer',
                company: 'Google',
                location: 'Mumbai',
                salary: '₹80,000',
                Description: 'Flutter Developer Job',
              ),
            );

          case '/test2':

            final data =
                settings.arguments as Map<String, dynamic>;

            return MaterialPageRoute(
              builder: (context) => Test2(
                title: data['title'],
                company: data['company'],
                location: data['location'],
                salary: data['salary'],
                Description: data['description'],
              ),
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