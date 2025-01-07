import 'package:clay_containers/widgets/clay_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/jsonload.dart';
import 'package:newsapp/pages/new_details_page.dart';
import 'package:timeago/timeago.dart';
class MySavedPage extends StatefulWidget{
  const MySavedPage({super.key});

  @override
  State<MySavedPage> createState() => _MySavedPageState();
}

class _MySavedPageState extends State<MySavedPage> {
  var json;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Saved Items',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35)),
      ),
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection('newsArticle').snapshots(), builder: (context,snapshot){
        if(snapshot.hasError)
        {
          return Center(
              child:Text('Could not display'));
        }
        if(snapshot.connectionState==ConnectionState.waiting)
        {
            return Center(
              child: CircularProgressIndicator(),
            );
        }
        if(snapshot.hasData)
        {
          QuerySnapshot<Map<String,dynamic>>? querySnapshot=snapshot.data as QuerySnapshot<Map<String,dynamic>>?;
          if(querySnapshot!=null) {
            return ListView.builder(itemBuilder: (context, index){
              bool isNull=false;

              DocumentSnapshot<Map<String, dynamic>> document = querySnapshot.docs[index];
              json = LoadJson.fromJson(document.data()!);
              print(json.author);
              print(json.title);
              if (json.urlToImage == null) {
                isNull = true;
                json.urlToImage = 'assets/images/filler.png';
              }
              if(json!=null) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetails(
                                    isSaved:true,
                                    docId: document.id,
                                    publishedAt: json.publishedAt!,
                                    title: json.title!,
                                    description: json.description!,
                                    author: json.author!,
                                    formattedDateTime: format(
                                        DateTime.parse(json.publishedAt!)),
                                    urlToImage: json.urlToImage!,
                                    isNull: false,
                                  )));
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
                                json.urlToImage,
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
                                  json.title,
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
                                    json.author,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, bottom: 8.0),
                                  child: Text(json.description,
                                    overflow: TextOverflow.ellipsis,),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            }, itemCount: querySnapshot.docs.length,);
          }
          return Center(
            child:Text('Couldn\'t load data'),
          );
        }
        return Center(
          child:Text('Couldn\'t load data'),
        );
      }),
    );
  }
}