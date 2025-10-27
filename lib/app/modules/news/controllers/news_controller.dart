import 'package:get/get.dart';
import 'package:medi/app/data/remote/model/news/news_response.dart';
import 'package:medi/app/data/remote/repository/news/news_repository.dart';

class NewsController extends GetxController {
  final newsList = <News>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllNews();
  }

  Future<void> getAllNews() async {
    var response = await NewsRepository().getAllNews();
    newsList.assignAll(response.news ?? []);
  }
}
