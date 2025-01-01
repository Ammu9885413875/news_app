import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/pages/homepage.dart';

class OtpPage extends StatefulWidget {
  final String verificationId;
  const OtpPage({super.key, required this.verificationId});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  var otpEntered=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Otp screen'),),
      body: Column(
        children: [
          TextField(
            controller: otpEntered,
          ),
          ElevatedButton(onPressed: (){
            try{
              PhoneAuthCredential credential=PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: otpEntered.text.toString());
              FirebaseAuth.instance.signInWithCredential(credential).then((value){
                navigateToPage();
              });
            }
            catch(e){
              showMessage('Error....');
            }
          }, child: Text('Verify')),
        ],
      ),
    );
  }

  void showMessage(msg) {
    SnackBar mySnack=SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(mySnack);
  }

  void navigateToPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
  }
}
