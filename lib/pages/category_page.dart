import 'dart:convert';

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/api_key.dart';
import 'package:timeago/timeago.dart';
import '../jsonload.dart';
import 'new_details_page.dart';

class MyCategoryPage extends StatefulWidget {
  final String? category;
  final String? searchText;
  const MyCategoryPage({super.key, this.category, this.searchText});

  @override
  State<MyCategoryPage> createState() => _MyCategoryPageState();
}

class _MyCategoryPageState extends State<MyCategoryPage> {
  DateTime publishedDateTime = DateTime.now();
  String formattedDifference = '0';
  Future<List<LoadJson>> readJson(int page) async {
    final String url;
    if (widget.category != null && widget.searchText != null) {
      url =
          'https://newsapi.org/v2/top-headlines?page=$page&category=${widget.category}&q=${Uri.encodeComponent(widget.searchText!)}&apiKey=${RetrieveApiKey.apiKey}';
    } else if (widget.category != null) {
      url =
          'https://newsapi.org/v2/top-headlines/?page=$page&category=${widget.category}&apiKey=${RetrieveApiKey.apiKey}';
    } else {
      url =
          'https://newsapi.org/v2/everything?page=$page&q=${Uri.encodeComponent(widget.searchText!)}&apiKey=${RetrieveApiKey.apiKey}';
    }
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final jsondata = response.body;
    Map<String, dynamic> jsonData = jsonDecode(jsondata);
    count = jsonData['totalResults'];
    List<dynamic> articles = jsonData['articles'];
    return articles.map((e) => LoadJson.fromJson(e)).toList();
  }
  var count = 0;
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: readJson(currentPage),
          builder: (context, data) {
            if (data.hasError) {
              return Text('Couldn\'t proceed');
            } else if (data.hasData)
            {
              var items = data.data as List<LoadJson>;
              if (items.isEmpty) {
                return Center(child: Text('No articles found.'));
              }
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    bool isNull = false;
                    publishedDateTime =
                        DateTime.parse(items[index].publishedAt!);
                    formattedDifference = format(publishedDateTime);
                    String? urlToImage = items[index].urlToImage;
                    if (urlToImage == null) {
                      isNull = true;
                      urlToImage = 'assets/images/filler.png';
                    }
                    String title = items[index].title ?? 'Title unavailable';
                    if (title.isEmpty) {
                      title = 'Title unavailable';
                    }
                    String author = items[index].author ?? 'Author unavailable';
                    if (author.isEmpty) {
                      author = 'Author unavailable';
                    }
                    String description =
                        items[index].description ?? 'Description unavailable';
                    if (description.isEmpty) {
                      description = 'Description unavailable';
                    }
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsDetails(
                                      title: title,
                                      description: description,
                                      author: author,
                                      formattedDateTime: formattedDifference,
                                      urlToImage: urlToImage!,
                                      isNull: isNull)));
                        },
                        child: ClayContainer(
                          borderRadius: 40,
                          spread: 25,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: !isNull
                                      ? Image.network(
                                          urlToImage,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                'assets/images/filler.png'); // Fallback image
                                          },
                                        )
                                      : Image.asset('assets/images/filler.png'),
                                ),
                              ),
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  title.toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                              )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, bottom: 8.0),
                                      child: Text(
                                        author.toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10.0, bottom: 8.0),
                                      child: Text(formattedDifference.toString(),overflow: TextOverflow.ellipsis,),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: items.length,
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ), 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  if (currentPage > 1) {
                    setState(() {
                      currentPage--;
                    });
                  } else {
                    showSnackBar('Already in first page', Colors.redAccent);
                  }
                },
                icon: Icon(
                  Icons.arrow_circle_left,
                )),
            IconButton(
                onPressed: () {
                  bool hasNextPage = count > currentPage * 20;
                  if (hasNextPage) {
                    setState(() {
                      currentPage++;
                    });
                  } else {
                    String msg = 'Reached end of the page';
                    showSnackBar(msg, Colors.redAccent);
                  }
                },
                icon: Icon(Icons.arrow_circle_right))
          ],
        ),
      ]
    );
  }

  showSnackBar(String msg, Color color) {
    SnackBar mySnack = SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(mySnack);
  }
}
