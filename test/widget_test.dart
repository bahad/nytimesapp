// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nytimes/features/home/home_page.dart';
import 'package:nytimes/features/home/news_model.dart';

void main() {
  NewsModel? newsModel = NewsModel(
      status: "OK",
      copyright:
          "Copyright (c) 2023 The New York Times Company.  All Rights Reserved.",
      numResults: 1,
      results: [
        Results(
            abstract:
                "Mr. Santos, a New York representative, said his relatives had helped guarantee his bail, but asked a judge to keep their names sealed out of privacy concerns.",
            publishedDate: "2023-06-09",
            title:
                "George Santos Says His Family Helped Bail Him Out. (Just Don’t Ask Who.)",
            media: [
              Media(mediaMetadata: [
                MediaMetadata(
                    url:
                        "https://static01.nyt.com/images/2023/06/09/multimedia/09santos-bail-tzwg/09santos-bail-tzwg-thumbStandard.jpg"),
              ])
            ]),
      ]);

  getData() async {
    return Future.delayed(const Duration(seconds: 1), () => newsModel);
  }

  testWidgets('News Home', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
  });
}
