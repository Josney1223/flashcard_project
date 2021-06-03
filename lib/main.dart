// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:flashcard_project/FrontEnd/DeckSelectionView.dart';
import 'package:flashcard_project/FrontEnd/Menu.dart';
import 'package:flashcard_project/FrontEnd/Sobre.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard APP',
      home: Menu(),
      routes: {
        '/deckSelection': (context) => DeckSelectionView(),
        '/sobre': (context) => Sobre()
      },
    );
  }
}
