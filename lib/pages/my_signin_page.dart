import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/widgets/snackBar.dart';
class MySignIn extends StatefulWidget {
  const MySignIn({super.key});
  @override
  State<MySignIn> createState() => _MySignInState();
}
class _MySignInState extends State<MySignIn> {
  var email=TextEditingController();
  var password=TextEditingController();
  bool isVisible=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.inversePrimary,
        title: Text('SignIn to NewsApp',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Glad to see you again 😊',style: TextStyle(color: Colors.blue,fontSize: 30),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              decoration: InputDecoration(
                  hintText: 'Enter email',
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: isVisible,
              controller: password,
              decoration: InputDecoration(
                  suffixIcon: InkWell(onTap: (){
                    isVisible=!isVisible;
                    setState(() {

                    });
                  },
                    child: Icon(Icons.remove_red_eye_outlined),),
                  hintText: 'Enter Password',
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
          ),
          ElevatedButton(onPressed: () async{
            try {
              await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email.text.toString(),
                  password: password.text.toString());
              popPage();
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfileCreation(title: 'Create profile',enabled: true,)));
            }on FirebaseAuthException catch(e){
              if(e.code=='user-not-found'){
                showSnack(msg: 'User not found', color: Colors.redAccent);
              }
              else if(e.code=='wrong-password'){
                showSnack(msg: 'Wrong password', color: Colors.redAccent);
              }
            }catch(e){
              showSnack(msg: 'Something went wrong', color: Colors.redAccent);
            }
          },
              child: Text('Verify')),
        ],
      ),
    );
  }
  showSnack({required String msg,required Color color}){
    var mySnack=SnackBarWidget();
    mySnack.showSnackBar(msg, color, context);
  }

  void popPage() {
    Navigator.pop(context);
  }
}

