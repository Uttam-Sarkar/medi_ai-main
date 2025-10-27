import 'package:medi/app/data/remote/model/news/news_response.dart';
import 'package:medi/app/network_service/api_client.dart';
import 'package:medi/app/network_service/api_end_points.dart';

class NewsRepository {
  Future<NewsResponse> getAllNews() async {
    var response =
        await ApiClient(customBaseUrl: 'https://mediai.tech/api/').get(
      ApiEndPoints.newsList,
      getAllNews,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => NewsResponse.fromJson(json),
      NewsResponse(),
    );
  }
}
