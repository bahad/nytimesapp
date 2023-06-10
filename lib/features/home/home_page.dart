// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytimes/core/color_manager.dart';
import 'package:nytimes/features/home/home_view_model.dart';
import 'package:nytimes/features/news_detail/news_detail_view.dart';
import 'package:provider/provider.dart';

import 'widgets/news_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.getNewsModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final homeViewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.instance.white,
        elevation: 0,
        title: Text(
          'Articles',
          style: TextStyle(color: ColorManager.instance.black, fontSize: 16.sp),
        ),
      ),
      body: const BuildHomeContent(),
    );
  }
}

class BuildHomeContent extends StatelessWidget {
  const BuildHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    if (homeViewModel.isLoading) {
      return const CircularProgressIndicator.adaptive();
    } else {
      return Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeViewModel.newsModel?.results?.length,
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailPage(
                              title: homeViewModel
                                      .newsModel?.results?[index].title ??
                                  "",
                            ),
                          ),
                        );
                      },
                      child: NewsListItem(
                        title: homeViewModel.newsModel?.results?[index].title ??
                            "",
                        abstract:
                            homeViewModel.newsModel?.results?[index].abstract ??
                                "",
                        publishedDate: homeViewModel
                                .newsModel?.results?[index].publishedDate ??
                            "",
                        mediaList:
                            homeViewModel.newsModel?.results?[index].media ??
                                [],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
