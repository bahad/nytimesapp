// ignore_for_file: unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nytimes/core/services/news_services.dart';
import 'package:nytimes/features/home/news_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nytimes/features/news_detail/news_detail_model.dart';

class MockHttpClient extends Mock implements Client {}

final queryParameters = {'api-key': "fAZmEwrF0BEo6MMsgjiWJf7tWP6dSsu2"};
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late NewsService newsService;
  late MockHttpClient mockHttpClient;
  setUp(() {
    newsService = NewsService();
    mockHttpClient = MockHttpClient();
  });
  group("News Home", () {
    test(
      "News Services Test",
      () async {
        when(() => mockHttpClient.get(Uri.https(
            "api.nytimes.com",
            "svc/mostpopular/v2/viewed/1.json",
            queryParameters))).thenAnswer((invocation) async {
          return Response('''{
            {
              "status": "OK",
    "copyright": "Copyright (c) 2023 The New York Times Company.  All Rights Reserved.",
    "num_results": 20,
    "results": [
        {
            "uri": "nyt://interactive/c8a7bcd8-ccdd-5397-9298-54701b9b3b80",
            "url": "https://www.nytimes.com/interactive/2023/06/08/upshot/new-york-city-smoke.html",
            "id": 100000008941928,
            "asset_id": 100000008941928,
            "source": "New York Times",
            "published_date": "2023-06-08",
            "updated": "2023-06-09 14:26:47",
            "section": "The Upshot",
            "subsection": "",
            "nytdsection": "the upshot",
            "adx_keywords": "Air Pollution;Wildfires;New York City",
            "column": null,
            "byline": "By Aatish Bhatia, Josh Katz and Margot Sanger-Katz",
            "type": "Interactive",
            "title": "Just How Bad Was the Pollution in New York?",
            "abstract": "The level of pollution Wednesday was higher than the worst day in San Francisco after major wildfires in 2018.",
            "des_facet": [
                "Air Pollution",
                "Wildfires"
            ],
            "org_facet": [],
            "per_facet": [],
            "geo_facet": [
                "New York City"
            ],
            "media": [
                {
                    "type": "image",
                    "subtype": "",
                    "caption": "",
                    "copyright": "",
                    "approved_for_syndication": 1,
                    "media-metadata": [
                        {
                            "url": "https://static01.nyt.com/images/2023/06/07/upshot/new-york-city-smoke-promo/new-york-city-smoke-promo-thumbStandard-v3.png",
                            "format": "Standard Thumbnail",
                            "height": 75,
                            "width": 75
                        },
                        {
                            "url": "https://static01.nyt.com/images/2023/06/07/upshot/new-york-city-smoke-promo/new-york-city-smoke-promo-mediumThreeByTwo210-v3.png",
                            "format": "mediumThreeByTwo210",
                            "height": 140,
                            "width": 210
                        },
                        {
                            "url": "https://static01.nyt.com/images/2023/06/07/upshot/new-york-city-smoke-promo/new-york-city-smoke-promo-mediumThreeByTwo440-v3.png",
                            "format": "mediumThreeByTwo440",
                            "height": 293,
                            "width": 440
                        }
                    ]
                }
            ],
            "eta_id": 0
        },
            }
          }''', 200);
        });

        final news = await NewsService().getNews();
        expect(news, isA<NewsModel>());
      },
    );
  });

  group("News Detail", () {
    test("News Detail", () async {
      when(() => mockHttpClient.get(Uri.https(
          "api.nytimes.com",
          "svc/search/v2/articlesearch.json",
          queryParameters))).thenAnswer((invocation) async {
        return Response('''
{
  "status": "OK",
  "copyright": "Copyright (c) 2023 The New York Times Company. All Rights Reserved.",
  "response": {
     "docs": [
        {
           "abstract": "The smoke from wildfires in Canada was expected to spread south and west across the United States starting Thursday.",
            "web_url": "https://www.nytimes.com/2023/06/08/us/wildfire-smoke-forecast-us-air-quality.html",
            "snippet": "The smoke from wildfires in Canada was expected to spread south and west across the United States starting Thursday.",
            "lead_paragraph": "The air quality in the Northeast and Mid-Atlantic should begin to improve on Thursday, according to a New York Times analysis of forecast models, as the dense mass of smoke that gripped those areas the day before becomes a more widespread haze that will cover most of the East Coast as far south as Florida.",
            "source": "The New York Times",
            "multimedia":[
              {
                        "rank": 0,
                        "subtype": "xlarge",
                        "caption": null,
                        "credit": null,
                        "type": "image",
                        "url": "images/2023/06/08/multimedia/08wildfires-blog-thursday-forecast-flkj/08wildfires-blog-thursday-forecast-flkj-articleLarge.jpg",
                        "height": 400,
                        "width": 600,
                        "legacy": {
                            "xlarge": "images/2023/06/08/multimedia/08wildfires-blog-thursday-forecast-flkj/08wildfires-blog-thursday-forecast-flkj-articleLarge.jpg",
                            "xlargewidth": 600,
                            "xlargeheight": 400
                        },
                        "subType": "xlarge",
                        "crop_name": "articleLarge"
                }
            ]
        }
     ],
     "meta": {
            "hits": 190448,
            "offset": 0,
            "time": 180
        }
  }
}
''', 200);
      });
      final newsDetailModel =
          await NewsService().getNewsDetail("when will it end? Sooner for");
      expect(newsDetailModel, isA<NewsDetailModel>());
    });
  });
}
