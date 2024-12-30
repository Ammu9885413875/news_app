import 'package:clay_containers/clay_containers.dart';
import 'package:newsapp/jsonload.dart';
import 'package:newsapp/news_details.dart';
import 'package:http/http.dart' as http;
import 'profilepage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:timeago/timeago.dart';
class MyHomePage extends StatefulWidget{
  const MyHomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }

}
class MyHomePageState extends State<MyHomePage>{
  DateTime publishedDateTime=DateTime.now();
  String formattedDifference='0';
  Future<List<LoadJson>> readJson(int page) async {
    final url='https://newsapi.org/v2/top-headlines/?country=us&page=$page&apiKey=f5f4d7290a324a23b6808a949d38aadd';
    final uri=Uri.parse(url);
    final response=await http.get(uri);
    final jsondata=response.body;
    Map<String, dynamic> jsonData = jsonDecode(jsondata);
    count=jsonData['totalResults'];
    List<dynamic> articles = jsonData['articles'];
    return articles.map((e)=>LoadJson.fromJson(e)).toList();
  }
  var count=0;
  int currentPage=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfilePage()));
          }, icon:const Icon(Icons.person_3),iconSize: 50,color: Colors.blueGrey,)
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection:Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,top: 8.0),
                  child: OutlinedButton(style:OutlinedButton.styleFrom(maximumSize: Size(200,40)),onPressed: (){}, child: const Text('Sports',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black)
                    ,textAlign: TextAlign.center,selectionColor: Colors.blue,)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,top: 8.0),
                  child: OutlinedButton(style:OutlinedButton.styleFrom(maximumSize: Size(200,40)),onPressed: (){}, child: const Text('Politics',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black)
                    ,textAlign:TextAlign.center,selectionColor: Colors.blue,)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,top: 8.0),
                  child: OutlinedButton(style:OutlinedButton.styleFrom(maximumSize: Size(200,40)),onPressed: (){}, child: const Text('Technology',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black,)
                    ,textAlign:TextAlign.center,selectionColor: Colors.blue,)),
                ),
              ],
            ),
          ),
          FutureBuilder(future: readJson(currentPage),
              builder:(context, data) {
                if(data.hasError)
                  {
                    return Text('Couldn\'t proceed');
                  }
                else if(data.hasData){
                  var items=data.data as List<LoadJson>;
                  print(count);
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        publishedDateTime=DateTime.parse(items[index].publishedAt!);
                        formattedDifference=format(publishedDateTime);
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: ClayContainer(
                          borderRadius: 40,
                          spread: 25,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  child: items[index].urlToImage!=null?ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image(image: NetworkImage(items[index].urlToImage.toString()))):Text('Image cant be displayed'),
                                  onTap: (){

                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetails(title: items[index].title.toString(),description: items[index].description.toString(),author: items[index].author.toString(),formattedDateTime: formattedDifference,urlToImage: items[index].urlToImage.toString(),)));
                                  },
                                ),
                              ),
                              Center(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(items[index].title.toString(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic
                                ),),
                              )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0,bottom: 8.0),
                                    child: Text(items[index].author.toString(),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0,bottom: 8.0),
                                    child: Text(formattedDifference),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );},
                      itemCount: count%20,
                    ),

                  );
                }
                else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){
                  if(currentPage>1)
                    {
                      setState(() {
                        currentPage--;
                      });
                    }
                  else{
                    showSnackBar('Already in first page',Colors.redAccent);
                  }
                }, icon: Icon(Icons.arrow_circle_left,)),
                IconButton(onPressed: (){
                  bool hasNextPage=count>currentPage*20;
                  if(hasNextPage) {
                    setState(() {
                      currentPage++;
                    });
                  }
                  else{
                    String msg='Reached end of the page';
                    showSnackBar(msg,Colors.redAccent);
                  }
                }, icon: Icon(Icons.arrow_circle_right))
              ],
            )
        ],
      ),
    );
  }
  showSnackBar(String msg,Color color)
  {
    SnackBar mySnack=SnackBar(content: Text(msg),duration: Duration(seconds: 1),backgroundColor: color,);
    ScaffoldMessenger.of(context).showSnackBar(mySnack);
  }

}