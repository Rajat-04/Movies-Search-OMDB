// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field, prefer_adjacent_string_concatenation, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:movies_api_omdb/controllers/searchController.dart';
import 'package:movies_api_omdb/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SearchController _searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 130,
        flexibleSpace: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search for movies",
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.search_outlined),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(
          () => _searchController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  itemCount: _searchController.moviesList?.length ?? 0,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio:
                          MediaQuery.of(context).size.width / 250),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 3, top: 6),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 120,
                        color: Color.fromARGB(255, 244, 243, 243),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                              16,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(_searchController
                                          .moviesList?[index].poster ??
                                      "https://www.freepnglogos.com/uploads/film-reel-png/film-reel-the-movies-owens-valley-12.png"),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _searchController
                                                .moviesList?[index].title ??
                                            "Movie Title",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${_searchController.moviesList?[index].title ?? "Action, Adventure, Science"}"
                                            .replaceAll(',', ' |'),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[400]),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Color.fromARGB(
                                                255, 99, 197, 115)),
                                        width: 80,
                                        height: 30,
                                        child: Center(
                                          child: Text(
                                            "${_searchController.moviesList?[index].title ?? "6.5"} IMDB",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
