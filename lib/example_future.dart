import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_application_future/models/users_model.dart';

class ExampleFuture extends StatefulWidget {
  const ExampleFuture({Key? key}) : super(key: key);

  @override
  _ExampleFutureState createState() => _ExampleFutureState();
}

/// Retorna los datos de todos los usuarios de
/// la Rest API
Future<UsersModel> getUsersDataFromAPI() async {
  UsersModel users;
  const url = 'https://reqres.in/api/users';
  final parseUrl = Uri.parse(
      url); //Parseamos la url para que no haya problemas en el envio de la petición.
  final response =
      await http.get(parseUrl); //http.get devuelve un Future<Response>
  final statusCode = response.statusCode; //Si statusCode es 200 está ok.
  if (statusCode == 200) {
    final rawJsonString =
        response.body; //Recuperamos el dato en formato JSON como un string.
    users = usersModelFromJson(
        rawJsonString); //Usando la dataClass creada parseamos la respuesta en un objeto que nos facilitará su manipulación.

  } else {
    throw HttpException('$statusCode');
  }
  return users;
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              final users = snapshot.data as UsersModel; //Casting a UsersModel
              return UsersListView(users: users.users, );
            }
            return Container();
          }
        },
      ),
    );
  }
}

class UsersListView extends StatelessWidget {
  final List<User> users;

  const UsersListView({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(users[index].firstName),
          subtitle: Text(users[index].lastName),    
        );
      },
    );
  }
}
