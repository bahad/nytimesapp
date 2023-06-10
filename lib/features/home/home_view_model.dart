import 'package:flutter/material.dart';
import 'package:nytimes/core/services/news_services.dart';
import 'package:nytimes/features/home/news_model.dart';

class HomeViewModel extends ChangeNotifier {
  bool isLoading = false;
  NewsModel? newsModel;

  getNewsModel() async {
    isLoading = true;
    newsModel = await NewsService().getNews();
    if (newsModel != null) {
      newsModel?.results
          ?.sort((a, b) => a.publishedDate!.compareTo(b.publishedDate!));
    }
    isLoading = false;
    notifyListeners();
  }
}
