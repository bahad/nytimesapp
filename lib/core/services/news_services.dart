// ignore_for_file: depend_on_referenced_packages, constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nytimes/features/home/news_model.dart';
import 'package:nytimes/features/news_detail/news_detail_model.dart';

const API_URL = "api.nytimes.com";

abstract class INewsService {
  INewsService();

  Future getNews();
  Future getNewsDetail(String q);
}

class NewsService implements INewsService {
  @override
  Future getNews() async {
    NewsModel? newsModel;
    final queryParameters = {'api-key': "fAZmEwrF0BEo6MMsgjiWJf7tWP6dSsu2"};
    try {
      final response = await get(
        Uri.http(API_URL, "svc/mostpopular/v2/viewed/1.json", queryParameters),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        newsModel = NewsModel.fromJson(decodedJson);
        return newsModel;
      } else {
        return 0;
      }
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  @override
  Future getNewsDetail(String q) async {
    NewsDetailModel? newsDetailModel;
    final queryParameters = {
      'q': q,
      'api-key': "fAZmEwrF0BEo6MMsgjiWJf7tWP6dSsu2",
    };
    try {
      final response = await get(
        Uri.https(API_URL, "svc/search/v2/articlesearch.json", queryParameters),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        newsDetailModel = NewsDetailModel.fromJson(decodedJson);
        return newsDetailModel;
      } else {
        return 0;
      }
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }
}
