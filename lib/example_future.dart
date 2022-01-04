import 'package:flutter/material.dart';

class ExampleFuture extends StatefulWidget {
  const ExampleFuture({Key? key}) : super(key: key);

  @override
  _ExampleFutureState createState() => _ExampleFutureState();
}

class _ExampleFutureState extends State<ExampleFuture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureBuilder'),
        backgroundColor: Colors.teal,
      ),
      body: Container(),
    );
  }
}
