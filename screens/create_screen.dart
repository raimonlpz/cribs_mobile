import 'package:flutter/material.dart';
import '../widgets/appbar_header.dart';

class CreateScreen extends StatelessWidget {
  static final routeName = '/create-screen';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarHeader('Add Event', Colors.black),
    );
  }
}
