// ignore_for_file: file_names, unused_local_variable, prefer_interpolation_to_compose_strings, unnecessary_cast, prefer_const_constructors

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movies_api_omdb/models/Movies.dart';
import 'package:movies_api_omdb/models/Search.dart';

class SearchController extends GetxController {
  var isLoading = false.obs;
  var searchList = [].obs as List;
  var moviesList = [].obs as List;
  var count = 0;
  @override
  Future<void> onInit() async {
    super.onInit();
    fetchData("thor");
  }

  void fetchData(String q) async {
    try {
      isLoading(true);
      searchList = [];
      moviesList = [];
      http.Response response = await http.get(
        Uri.tryParse(
          "http://www.omdbapi.com/?apikey=85404711&type=movie&s=" + q,
        )!,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Response'] == 'False') {
          searchList = [];
          moviesList = [];
        } else {
          searchList = result['Search'].map((m) => Search.fromJson(m)).toList();
          print(searchList[0].title);
          await Future.forEach(searchList, (item) async {
            print(item.toString());
            http.Response movieresponse = await http.get(
              Uri.tryParse(
                "http://www.omdbapi.com/?apikey=85404711&type=movie&t=" +
                    item.title.toString(),
              )!,
            );
            if (movieresponse.statusCode == 200) {
              var res = jsonDecode(movieresponse.body);
              moviesList.add(Movies.fromJson(res));
            }
          });
        }
      }
      if (count == 0) {
        Get.snackbar(
          "Pro Tip",
          "Click on movie tile to see description in snackbar!",
          duration: Duration(seconds: 5),
        );
        count = 1;
      }
    } catch (e) {
      Get.snackbar("Fetching Unsuccessful", "$e");
    } finally {
      isLoading(false);
    }
  }

  void updateName(String movieName) {
    fetchData(movieName);
  }
}
