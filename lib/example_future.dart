import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFuture extends StatefulWidget {
  const ExampleFuture({Key? key}) : super(key: key);

  @override
  _ExampleFutureState createState() => _ExampleFutureState();
}

/// Retorna los datos de todos los usuarios de 
/// la Rest API
Future<Map> getUsersDataFromAPI() async{
  var jsonMap = {};
  const url = 'https://reqres.in/api/users';
  final parseUrl = Uri.parse(url); //Parseamos la url para que no haya problemas en el envio de la petición.
  final response = await http.get(parseUrl); //http.get devuelve un Future<Response>
  final statusCode = response.statusCode; //Si statusCode es 200 está ok. 
  if( statusCode == 200){ 
    final rawJsonString = response.body; //Recuperamos el dato en formato JSON como un string.
    jsonMap = jsonDecode(rawJsonString);
  }else{
    throw HttpException('$statusCode');
  }

  return jsonMap;
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
        future: getUsersDataFromAPI(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else{
            if(snapshot.hasData){
              final rawData = snapshot.data;
              print(rawData);
            }
            return Container();
          }
       
        },
      ),
    );
  }
}
