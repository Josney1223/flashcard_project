// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flashcard_project/FrontEnd/DeckCollectionView.dart';
import 'package:flashcard_project/FrontEnd/EditFlashcard.dart';
import 'package:flashcard_project/FrontEnd/FlashcardCollectionView.dart';
import 'package:flashcard_project/FrontEnd/InGame.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_project/FrontEnd/DeckSelectionView.dart';
import 'package:flashcard_project/FrontEnd/Menu.dart';
import 'package:flashcard_project/FrontEnd/Sobre.dart';
import 'package:flashcard_project/FrontEnd/PersistDeck.dart';
import 'package:provider/provider.dart';
import 'package:flashcard_project/BackEnd/Collection/Collection.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Collection(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcard APP',
      home: Menu(),
      routes: {
        '/deckSelection': (context) => DeckSelectionView(),
        '/sobre': (context) => Sobre(),
        '/deckCollection': (context) => DeckCollectionView(),
        FlashcardCollectionView.routeName: (context) =>
            FlashcardCollectionView(),
        PersistDeck.routeName: (context) => PersistDeck(),
        EditFlashcard.routeName: (context) => EditFlashcard(),
        DeckSelectionView.routeName: (context) => DeckSelectionView(),
        InGame.routeName: (context) => InGame(),
      },
    );
  }
}
