import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../news_model.dart';

class NewsListItem extends StatelessWidget {
  final List<Media> mediaList;
  final String title, abstract, publishedDate;

  const NewsListItem(
      {super.key,
      required this.mediaList,
      required this.title,
      required this.abstract,
      required this.publishedDate});

  @override
  Widget build(BuildContext context) {
    if (mediaList.isEmpty) {
      return const SizedBox();
    }
    if (mediaList.first.mediaMetadata == null) {
      return const SizedBox();
    } else {
      return Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: Container(
                height: 110.w,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          mediaList.first.mediaMetadata![1].url ?? ""),
                    )),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'satoshi-medium',
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    abstract,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'satoshi-regular',
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: 3.w),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        publishedDate,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'satoshi-regular',
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}
