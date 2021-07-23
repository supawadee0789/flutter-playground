import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:mirrors';


@override
_MyHomePageState createState() => _MyHomePageState();

abstract class BaseStateful<T extends State> extends StatefulWidget {
  initailState() => T;

  @override
  T createState() => initailState();

  showDialogLoading() {
    // TODO: handle to show dialog loading
  }

  dismissDialogLoading() {
    // TODO: handle to dismiss dialog
  }
}

class MyHomePage extends BaseStateful<_MyHomePageState> {
  MyHomePage({Key? key, required this.title});

  final String title;

  @override
  initailState() {
    return _MyHomePageState();
  }
}

class Album {
  final int userId;
  final int id;
  final String title;
  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    print('construtor');
  }

  @override
  void initState() {
   print("init state");
   FetchUtils.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'), Album,(body: Album) =>{ } );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(widget.title),
    ));
  }
}

typedef void onSuccess(T);

class FetchUtils {
  FetchUtils._() {
    throw ("prevent to new obj");
  }

  static Future<T> get(String uri,class target, onSuccess callback) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      var body = target.fromJson(jsonDecode(response.body));
      callback(body);
    } else if (response.statusCode == 401) {
      // TODO: handle unauthorize
    } else {
      // TODO: show dialog error with message
    }
  }
}
