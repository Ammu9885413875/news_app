import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilePage extends StatefulWidget{
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String userName='not specified';
  String bio='nothing to show';
  String phoneNo='nothing to show';
  String email='nothing to show';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:const Text('Profile page',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLoginPage(title:'Edit profile')));
            }, icon: Icon(Icons.edit,size: 25,)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){
              logOut();
            }, icon: Icon(Icons.logout)),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClayContainer(
            height: 400,
            spread: 30,
            customBorderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomLeft: Radius.circular(50)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClayContainer(height: 100,
                    width: 100,
                    borderRadius: 50,
                    spread: 25,child: Center(child: const Text('R',style: TextStyle(fontSize: 50,fontWeight:FontWeight.bold,fontStyle: FontStyle.italic),)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Username : $userName',
                    style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: double.infinity,
                    ),
                    child: Text(
                      'Bio : $bio',
                      style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Text(
                    'email : $email',
                    style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Phone no : $phoneNo',
                    style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void fetchData() async{
    var prefs=await SharedPreferences.getInstance();
    userName=prefs.getString('userName')??userName;
    bio=prefs.getString('bio')??bio;
    phoneNo=prefs.getString('phoneNo')??phoneNo;
    email=prefs.getString('email')??email;
    setState(() {

    });
  }

  void logOut() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyLoginPage(title: 'Create profile')),(route) => false,);
  }
}