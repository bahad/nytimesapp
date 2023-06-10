// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:nytimes/features/news_detail/news_detail_view_model.dart';
import 'package:provider/provider.dart';
import '../../core/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsDetailPage extends StatefulWidget {
  final String title;
  const NewsDetailPage({super.key, required this.title});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  void initState() {
    final newsDetailViewModel =
        Provider.of<NewsDetailViewModel>(context, listen: false);
    newsDetailViewModel.getNewsDetailModel(widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: ColorManager.instance.black),
        backgroundColor: ColorManager.instance.white,
        elevation: 0,
        title: Text(
          widget.title,
          style: TextStyle(color: ColorManager.instance.black, fontSize: 16.sp),
        ),
      ),
      body: const Scrollbar(
          child: SingleChildScrollView(child: BuildNewsDetailContent())),
    );
  }
}

class BuildNewsDetailContent extends StatelessWidget {
  const BuildNewsDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    final newsDetailViewModel = Provider.of<NewsDetailViewModel>(context);
    if (newsDetailViewModel.isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    } else {
      return Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            newsDetailViewModel
                        .newsDetailModel?.response?.docs?.first.multimedia !=
                    null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: CachedNetworkImage(
                        imageUrl:
                            "https://www.nytimes.com/${newsDetailViewModel.newsDetailModel?.response?.docs?.first.multimedia?.first.url}"),
                  )
                : const SizedBox(),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                children: [
                  Text(
                    newsDetailViewModel
                            .newsDetailModel?.response?.docs?.first.source ??
                        "",
                    style: TextStyle(
                        fontFamily: 'satoshi-medium',
                        fontSize: 16.sp,
                        color: ColorManager.instance.primary),
                  ),
                  SizedBox(width: 10.w),
                  newsDetailViewModel
                              .newsDetailModel?.response?.docs?.first.pubDate !=
                          null
                      ? Text(
                          newsDetailViewModel.newsDetailModel?.response?.docs
                                  ?.first.pubDate
                                  ?.substring(0, 10) ??
                              "",
                          style: TextStyle(
                            fontFamily: 'satoshi-regular',
                            fontSize: 15.sp,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:
                  newsDetailViewModel.newsDetailModel?.response?.docs?.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 6.w),
                      child: Text(
                        newsDetailViewModel.newsDetailModel?.response
                                ?.docs?[index].headline?.main ??
                            "",
                        style: TextStyle(
                            fontSize: 15.sp, fontFamily: 'satoshi-bold'),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.w),
                      child: Text(
                        newsDetailViewModel.newsDetailModel?.response
                                ?.docs?[index].leadParagraph ??
                            "",
                        style: TextStyle(
                            fontSize: 15.sp, fontFamily: 'satoshi-regular'),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    }
  }
}
