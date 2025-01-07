import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/jsonload.dart';
import 'package:newsapp/load_user.dart';
import 'package:newsapp/pages/mysavedpage.dart';
import 'package:newsapp/widgets/bottom_nav_bar.dart';
import 'package:newsapp/widgets/snackBar.dart';

class NewsDetails extends StatefulWidget {
  final String title;
  final String description;
  final String author;
  final String formattedDateTime;
  final String urlToImage;
  final bool isNull;
  final String publishedAt;
  final bool isSaved;
  final String? docId;
  const NewsDetails({
    super.key,
    this.docId,
    required this.isSaved,
    required this.publishedAt,
    required this.title,
    required this.description,
    required this.author,
    required this.formattedDateTime,
    required this.urlToImage,
    required this.isNull,
  });

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Builder(
            builder: (context) {
              return !(widget.isSaved)?IconButton(onPressed: (){
                saveArticle();
              }, icon: Icon(Icons.bookmark,size: 30,)):IconButton(onPressed: (){
                deleteArticle(docId:widget.docId!);
              }, icon: Icon(Icons.delete));
            }
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClayContainer(
            borderRadius: 40,
            spread: 25,
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:22.0,right: 8.0,left: 8.0,bottom: 8.0,),
                  child: ClipRRect(
                      borderRadius:BorderRadius.circular(40),
                      child: getImage(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.title,style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic,),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: double.infinity),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text(overflow: TextOverflow.ellipsis,widget.author,style: TextStyle(fontSize: 18),)),
                        Flexible(child: Text(widget.formattedDateTime,style: TextStyle(fontSize: 18))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 350),
                      child: Text(widget.description,style: TextStyle(fontSize: 20,color: Colors.black,fontStyle: FontStyle.italic),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  saveArticle() async{
    try {
      LoadJson json = LoadJson(urlToImage: widget.urlToImage,
          title: widget.title,
          author: widget.author,
          publishedAt: widget.publishedAt,
          description: widget.description);
      var dbInstance = FirebaseFirestore.instance;
      await dbInstance.collection('newsArticle').add(json.toJson());
      SnackBarWidget mySnack=SnackBarWidget();
      mySnack.showSnackBar('Added the article', Colors.greenAccent, context);
    }
    catch(e)
    {
      print(e);
      SnackBarWidget mySnack=SnackBarWidget();
      mySnack.showSnackBar('Couldn\'t add the article...', Colors.redAccent, context);
    }
  }
  Widget getImage(){
    try {
      return Image.network(widget.urlToImage,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/images/filler.png');
        },
      );
    }catch (e) {
      return Image.asset('assets/images/filler.png');
    }
  }

  Future<bool> documentExists({required String docId}) async{
    var docRef=FirebaseFirestore.instance.collection('newsArticle').doc(docId);
    final docSnapshot=await docRef.get();
    return docSnapshot.exists;
  }

  void deleteArticle({required String docId}) async{
    try {
      FirebaseFirestore.instance.collection('newsArticle').doc(docId).delete();
      SnackBarWidget().showSnackBar(
          'Removed from saved articles', Colors.greenAccent, context);
      Navigator.pop(context);
    }
    catch(e){
      SnackBarWidget().showSnackBar('Couldn\'t remove the article', Colors.red, context);
    }
  }
}