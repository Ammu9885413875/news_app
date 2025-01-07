import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyProfileCreation extends StatefulWidget {
  final String title;
  final bool enabled;
  const MyProfileCreation({super.key,required this.title,required this.enabled});

  @override
  State<MyProfileCreation> createState() => _MyProfileCreationState();
}

class _MyProfileCreationState extends State<MyProfileCreation> {
  var userName=TextEditingController();
  var bio=TextEditingController();
  var phoneNo=TextEditingController();
  var email=TextEditingController();
  var user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    String title=widget.title;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.inversePrimary,
        title: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Welcome ${user!.email} 🤩',style: TextStyle(color: Colors.blue,fontSize: 25),),
          Text('How are you????',style: TextStyle(color: Colors.blue,fontSize: 20),),
          TextField(
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 3,
            controller: bio,
            decoration: InputDecoration(
              hintText: 'A brief bio',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black,
                    )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(20),
                )

            ),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: phoneNo,
            decoration: InputDecoration(
              hintText: 'Phone number',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black,
                    )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(20),
                )

            ),
          ),
          ElevatedButton(onPressed: (){
            storeAll();
            Navigator.pop(context);

            //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationBars()),(route)=>false);
          }, child: Text('Submit'))
        ],
      ),
    );
  }

  void storeAll() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString('userName', userName.text.toString());
    prefs.setString('bio', bio.text.toString());
    prefs.setString('phoneNo', phoneNo.text.toString());
  }
}
