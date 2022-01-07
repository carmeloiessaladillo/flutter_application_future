import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      body: FutureBuilder(
        future: http.get(Uri.parse('https://reqres.in/api/users')),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else{
            if(snapshot.hasData){
              final rawData = snapshot.data as http.Response;
              final jsonMap = jsonDecode(rawData.body);
              print(jsonMap['data']);
            }
            return Container();
          }
       
        },
      ),
    );
  }
}
