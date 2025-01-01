import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NewsDetails extends StatelessWidget {
  final String title;
  final String description;
  final String author;
  final String formattedDateTime;
  final String urlToImage;
  final bool isNull;

  const NewsDetails({
    super.key,
    required this.title,
    required this.description,
    required this.author,
    required this.formattedDateTime,
    required this.urlToImage,
    required this.isNull,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Builder(
            builder: (context) {
              return IconButton(onPressed: (){
                SnackBar mySnack=SnackBar(content: Text('Item saved',style: TextStyle(fontSize: 18),),
                  duration: Duration(seconds: 3),
                );
                ScaffoldMessenger.of(context).showSnackBar(mySnack);

              }, icon: Icon(Icons.bookmark,size: 30,));
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
                      child: !isNull?Image(image: NetworkImage(urlToImage),):Image(image: AssetImage(urlToImage))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title,style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic,),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: double.infinity),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text(overflow: TextOverflow.ellipsis,author,style: TextStyle(fontSize: 18),)),
                        Flexible(child: Text(formattedDateTime,style: TextStyle(fontSize: 18))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 350),
                      child: Text(description,style: TextStyle(fontSize: 20,color: Colors.black,fontStyle: FontStyle.italic),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}