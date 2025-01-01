import 'package:flutter/material.dart';
import 'package:newsapp/pages/category_page.dart';
class MySearchPage extends StatefulWidget{
  const MySearchPage({super.key});

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}
class _MySearchPageState extends State<MySearchPage> {
  String? category;

  var searchText=TextEditingController();
  String? text;
  var isSelected=[false,false,false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('News App',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: searchText,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black,width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.blue,width: 4),
                ),
                prefixIcon:const Icon(Icons.search),
                hintText: 'Search Here ..........',
                suffixIcon: IconButton(onPressed: (){
                  text=searchText.text.toString();
                  setState(() {

                  });
                }, icon: Icon(Icons.arrow_forward_rounded)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(style:ElevatedButton.styleFrom(
                backgroundColor: isSelected[0]?Colors.blue:Colors.grey,
              ),onPressed: (){
                text=searchText.text.toString();
                isSelected=[false,false,false];
                isSelected[0]=true;
                category='sports';
                setState(() {

                });
              }, child: Text('Sports')),
              ElevatedButton(style:ElevatedButton.styleFrom(
                backgroundColor: isSelected[1]?Colors.blue:Colors.grey,
              ),onPressed: (){
                text=searchText.text.toString();
                isSelected=[false,false,false];
                isSelected[1]=true;
                category='politics';
                setState(() {

                });
              }, child: Text('Politics')),
              ElevatedButton(style:ElevatedButton.styleFrom(
                backgroundColor: isSelected[2]?Colors.blue:Colors.grey,
              ),onPressed: (){
                text=searchText.text.toString();
                isSelected=[false,false,false];
                isSelected[2]=true;
                category='technology';
                setState(() {

                });
              }, child: Text('Technology')),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder<Widget>(
                future: showContent(), // Use FutureBuilder to get the initial page
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the future to complete, show a loading indicator
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Handle any errors that occur during the future
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    // Once the future completes, return the appropriate page
                    return snapshot.data!;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<Widget> showContent() async {
    if(text==null)
    {
        return Center(child: Text('Noting to display'));
    }
    else if(text!.isEmpty)
    {
      return Center(child: Text('Enter something to search'),);
    }
    else if(category==null) {
      return MyCategoryPage(searchText: text,);
    }
    return MyCategoryPage(searchText: text,category: category,);
  }
}