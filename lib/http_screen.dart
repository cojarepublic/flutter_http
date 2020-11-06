import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'student_model.dart';

class HttpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<StudentModel>(
          future: getStudent(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final student = snapshot.data;
              return Text('Name: ${student.name} \n Education: ${student.education} \n Skill: ${student.skill}');

            }else if(snapshot.hasError){

              return Text(snapshot.error.toString());
            }else{
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

Future<StudentModel> getStudent() async {
  final url ='https://api.jsonbin.io/b/5e1219328d761771cc8b9394';
  final response = await http.get(url);

  if(response.statusCode == 200){
    Map<String, dynamic> jsonStudent = jsonDecode(response.body);

    return StudentModel.fromJson(jsonStudent);
  } else{
    throw Exception();
  }



}
