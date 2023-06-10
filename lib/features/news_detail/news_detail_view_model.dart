import 'package:flutter/material.dart';
import 'package:nytimes/features/news_detail/news_detail_model.dart';

import '../../core/services/news_services.dart';

class NewsDetailViewModel extends ChangeNotifier {
  bool isLoading = false;
  NewsDetailModel? newsDetailModel;

  getNewsDetailModel(String q) async {
    isLoading = true;
    newsDetailModel = await NewsService().getNewsDetail(q);
    isLoading = false;
    notifyListeners();
  }
}
