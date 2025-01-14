import 'package:clay_containers/widgets/clay_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/jsonload.dart';
import 'package:newsapp/pages/new_details_page.dart';
import 'package:timeago/timeago.dart';

class MySavedPage extends StatefulWidget {
  const MySavedPage({super.key});

  @override
  State<MySavedPage> createState() => _MySavedPageState();
}

class _MySavedPageState extends State<MySavedPage> {
  static int filterDays=30;
  late DateTime filterDate=DateTime.now().subtract(Duration(days: filterDays));
  var user=FirebaseAuth.instance.currentUser;
  updateFilterDate(){
    filterDate = DateTime.now().subtract(Duration(days: filterDays));
    return filterDate;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(onPressed: (){
              Scaffold.of(context).openDrawer();
            }, icon: Icon(Icons.filter_list_alt,size: 40,));
          }
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: const Text('Saved Items',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 75,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('By default saved items from 30 days are displayed',style: TextStyle(color: Colors.white,fontSize: 22),),
              ),
            ),
            TextButton(onPressed: (){
              filterDays=7;
              setState(() {
                updateFilterDate();
              });
              Navigator.pop(context);
            }, child: Text('7 days',style: TextStyle(color: Colors.blue,fontSize: 20),)),
            TextButton(onPressed: (){
              filterDays=14;
              setState(() {
                updateFilterDate();
              });
              Navigator.pop(context);
            }, child: Text('14 days',style: TextStyle(color: Colors.blue,fontSize: 20))),
            TextButton(onPressed: (){
              filterDays=30;
              setState(() {
                updateFilterDate();
              });
              Navigator.pop(context);
            }, child: Text('30 days',style: TextStyle(color: Colors.blue,fontSize: 20))),
            TextButton(onPressed: (){
              filterDays=60;
              setState(() {
                updateFilterDate();
              });
              Navigator.pop(context);
            }, child: Text('60 days',style: TextStyle(color: Colors.blue,fontSize: 20))),
          ],
        )
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('users').doc(user!.email).collection('newsArticle').orderBy('timeStamp',descending: false).where('timeStamp',isGreaterThanOrEqualTo: filterDate).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Could not display'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              QuerySnapshot<Map<String, dynamic>>? querySnapshot =
                  snapshot.data;
              if (querySnapshot != null) {
                return querySnapshot.docs.isEmpty
                    ? Center(
                        child: Text('No articles saved'),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          bool isNull = false;

                          DocumentSnapshot<Map<String, dynamic>> document =
                              querySnapshot.docs[index];
                          var json = LoadJson.fromJson(document.data()!);
                          if (json.urlToImage == null) {
                            isNull = true;
                            json.urlToImage = 'assets/images/filler.png';
                          }
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsDetails(
                                              isSaved: true,
                                              docId: document.id,
                                              publishedAt: json.publishedAt!,
                                              title: json.title!,
                                              description: json.description!,
                                              author: json.author!,
                                              formattedDateTime: format(
                                                  DateTime.parse(
                                                      json.publishedAt!)),
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
                                                json.urlToImage!,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.asset(
                                                      'assets/images/filler.png'); // Fallback image
                                                },
                                              )
                                            : Image.asset(
                                                'assets/images/filler.png'),
                                      ),
                                    ),
                                    Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        json.title!,
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
                                              json.author ?? 'Not available',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0, bottom: 8.0),
                                            child: Text(
                                              formattedDate(json.publishedAt) ??
                                                  'Not available',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: querySnapshot.docs.length,
                      );
              }
              return Center(
                child: Text('Couldn\'t load data'),
              );
            }
            return Center(
              child: Text('Couldn\'t load data'),
            );
          }),
    );
  }

  formattedDate(String? published) {
    if (published == null) {
      return Text('Not available');
    }
    return format(DateTime.parse(published));
  }
}
