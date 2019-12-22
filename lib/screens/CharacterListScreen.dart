import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screens/CharacterListItemScreen.dart';
import '../models/Characters.dart';

class CharacterListScreen extends StatefulWidget {
  final Future<Characters> characters;

  CharacterListScreen(this.characters);
  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comics'),
      ),
      body: Center(
        child: FutureBuilder<Characters>(
          future: widget.characters,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView(
                padding: const EdgeInsets.all(25),
                children: snapshot.data.data.results.map(
                  (result) {
                    return CharacterListItemScreen(result);
                  },
                ).toList(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
