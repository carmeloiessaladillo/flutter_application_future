import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/users_model.dart';


class ExampleStream extends StatefulWidget {
  const ExampleStream({Key? key}) : super(key: key);

  @override
  _ExampleStreamState createState() => _ExampleStreamState();
}

class _ExampleStreamState extends State<ExampleStream> {
  StreamController<List<User>> _streamController = StreamController();
  List<User> _users = [];

  @override
  void initState() {
    //getAllUsers();
    _users = [];
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => getAllUsers());
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    _users.clear();
    super.dispose();
  } 

  Future<void> getAllUsers() async{
    //Obtenemos la primera página.
    UsersModel firstUsers = await getUsersPage();
    _streamController.add(firstUsers.users);
    for(int i=2;i<=firstUsers.totalPages;i++){ 
      Future.delayed(const Duration(seconds: 2), () async{
              _streamController.add((await getUsersPage(page: i)).users);
      });
    }
  }

  Future<UsersModel> getUsersPage({int page = 0}) async {
  UsersModel users;
  var url = 'https://reqres.in/api/users';
  if(page >= 1){
    url += '?page=$page';
  }
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamBuilder'),
        backgroundColor: Colors.amber,
      ),
      body: StreamBuilder(
        stream: _streamController.stream,
        builder: (context, AsyncSnapshot<List<User>> snapshot) {        
        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator());
        }else{
          //UsersModel userModel = snapshot.data as UsersModel;
          _users.addAll(snapshot.data!);
          return ListView.builder(
            itemCount: _users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_users.elementAt(index).firstName),
                subtitle: Text(_users.elementAt(index).lastName),
              );
          },);
        }
      },)
    );
  }
}
