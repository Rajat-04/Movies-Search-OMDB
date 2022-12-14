// ignore_for_file: file_names, unused_local_variable, prefer_interpolation_to_compose_strings, unnecessary_cast

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movies_api_omdb/models/Movies.dart';
import 'package:movies_api_omdb/utils/constants.dart';

class SearchController extends GetxController {
  var isLoading = false.obs;
  List<dynamic>? moviesList;
  var constants = Constants();
  @override
  Future<void> onInit() async {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading(true);
      http.Response response = await http.get(
        Uri.tryParse(
          "http://www.omdbapi.com/?apikey=85404711&type=movie&s=thor",
        )!,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        moviesList = result['Search'].map((m) => Movies.fromJson(m)).toList();
        print(moviesList);
        //movie = Movies.fromJson(result);
      }
    } catch (e) {
      print("Fetching Unsuccessful, error is $e");
    } finally {
      isLoading(false);
    }
  }
}
