import 'package:clay_containers/clay_containers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/pages/profile_creation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyProfilePage extends StatefulWidget{
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String? bio;
  String? phoneNo;
  var user=FirebaseAuth.instance.currentUser;
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfileCreation(title:'Edit profile',enabled: false,)));
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
                    'Username : ${user?.displayName??user?.email}',
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
                      'Bio : ${bio??'A brief bio please 😇'}',
                      style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Text(
                    'email : ${user?.email??'No email'}',
                    style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Phone no : ${phoneNo??'Phone number please... 📞'}',
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
    bio=prefs.getString('bio')??bio;
    phoneNo=prefs.getString('phoneNo')??phoneNo;
    setState(() {

    });
  }

  void logOut() async{
    await FirebaseAuth.instance.signOut();
    popPage();
    // SharedPreferences prefs=await SharedPreferences.getInstance();
    // prefs.setBool('isLoggedIn', false);
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyLoginPage(title: 'Create profile')),(route) => false,);
  }

  void popPage() {
    Navigator.pop(context);
  }
}