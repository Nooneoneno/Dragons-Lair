import 'package:DragOnPlay/api_service/api_handler.dart';
import 'package:DragOnPlay/api_service/api_service.dart';
import 'package:DragOnPlay/controllers/utility.dart';
import 'package:DragOnPlay/entities/category.dart';
import 'package:DragOnPlay/entities/video_game.dart';
import 'package:DragOnPlay/entities/video_game_partial.dart';

class ApiController {
  Future<VideoGamePartial> getPartialGame(int id) async {
    final videoGamePartialJson = Utility.parseJson(await ApiService.fetchGamePartial(query: "where id=$id;"));

    return VideoGamePartial.fromJson({
      ...videoGamePartialJson[0],
      'coverUrl': Utility.extractCoverUrl(videoGamePartialJson[0]['cover']),
    });
  }

  Future<VideoGame> getGame(int id) async {
    final videoGameJson = Utility.parseJson(await ApiService.fetchGame(query: "where id=$id;"));

    return VideoGame.fromJson({
      ...videoGameJson[0],
      'coverUrl': Utility.extractCoverUrl(videoGameJson[0]['cover']),
    });
  }

  Future<List<VideoGamePartial>> getSearchResults(String query) async {
    if (query.length < 2) return [];

    final rawResponse = await ApiService.fetchGamePartial(
        sort: 'sort rating desc;',
        query: 'where name ~ "$query"* & category=(0,1,2,3,4,8,9,11);',
        limit: 'limit 10;');
    return Utility.mapToVideoGamePartialList(rawResponse);
  }

  Stream<List<VideoGamePartial>> getCatalog(int categoryId) async* {
    const int limit = 500;
    int offset = 0;
    bool hasMoreData = true;
    List<VideoGamePartial> catalog = [];

    while (hasMoreData) {
      final List<dynamic> jsonResponse = Utility.parseJson(
          await ApiService.fetchGamePartial(
              sort: 'sort name asc;',
              query: 'where genres=$categoryId;',
              limit: 'limit $limit;',
              offset: 'offset ${offset * limit};'));

      if (jsonResponse.isEmpty) {
        hasMoreData = false;
      } else {
        catalog.addAll(Utility.mapJsonToVideoGamePartials(jsonResponse));
        yield catalog;
        offset++;
      }
    }
  }

  Future<List<VideoGamePartial>> getMostRated(int categoryId) async {
    final rawResponse = await ApiService.fetchGamePartial(
        sort: 'sort aggregated_rating desc;',
        query: 'where genres=$categoryId & aggregated_rating >= 75;',
        limit: 'limit 500;');
    return Utility.mapToVideoGamePartialList(rawResponse);
  }

  Future<List<VideoGamePartial>> fetchPopularGames(
      int limit, int offset) async {
    final gameIds = await ApiService.fetchPopularGameIds(3, limit, offset);
    if (gameIds.isEmpty) return [];

    final videoGamePartialJsonList = await ApiService.fetchGamePartial(
        query: 'where id = (${gameIds.join(', ')});', limit: 'limit $limit;');
    return Utility.mapToUniqueVideoGamePartialList(videoGamePartialJsonList);
  }

  Future<List<VideoGamePartial>> fetchNewRelease() async {
    final nowTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final lastWeekTimestamp = nowTimestamp - (7 * 24 * 60 * 60);

    final videoGamePartialJsonList = await ApiService.fetchGamePartial(
        sort: 'sort hypes desc;',
        query:
            'where first_release_date > $lastWeekTimestamp & first_release_date < $nowTimestamp;',
        limit: 'limit 25;');

    List<VideoGamePartial> newReleases = Utility.mapToUniqueVideoGamePartialList(videoGamePartialJsonList);
    newReleases.sort((a, b) => b.firstReleaseDate.compareTo(a.firstReleaseDate));
    return newReleases;
  }

  Future<List<Category>> getCategoriesName() async {
    final rawResponse =
        await ApiHandler.postRequest("/genres", "fields id, name; limit 500;");

    return Utility.parseJson(rawResponse).map<Category>((categoryData) {
      return Category.fromJson({
        ...categoryData,
        'imageUrl': '',
        'categoryType': CategoryType.genre
      });
    }).toList();
  }

  Future<Category> _fetchCategoryImage(Category category) async {
    final query = "genres=${category.id}";
    final imageUrl = await getCover(query);

    category.imageUrl = imageUrl;
    return category;
  }

  Stream<Category> fetchCategoryImages(List<Category> categories) async* {
    const int batchSize = 4;
    for (int i = 0; i < categories.length; i += batchSize) {
      final batch = categories.sublist(
          i,
          i + batchSize > categories.length
              ? categories.length
              : i + batchSize);
      final futureCategories = batch.map(_fetchCategoryImage).toList();

      yield* Stream.fromIterable(await Future.wait(futureCategories));
    }
  }

  Future<String> getCover(String query) async {
    final videoGamePartialJsonList = Utility.parseJson(
        await ApiService.fetchGamePartial(
            sort: 'sort rating desc;',
            query: 'where $query;',
            limit: 'limit 1;'));

    return videoGamePartialJsonList.isNotEmpty
        ? Utility.extractCoverUrl(videoGamePartialJsonList[0]['cover'])
        : '';
  }
}
