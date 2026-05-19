import 'package:flutter/material.dart';

class FragmentHolder extends StatefulWidget {
  @override
  _FragmentHolderState createState() => _FragmentHolderState();
}

class _FragmentHolderState extends State<FragmentHolder> {
  
  final string = []; 
  
  @override
  Widget build(BuildContext context) {
    return Container(

      child: HomePage1(),
    );
  }
}