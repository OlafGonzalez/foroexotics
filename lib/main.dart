import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'agregarCarro.dart';
import 'Carpost.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  List<CarPost> carpostList = [];
  @override
  void initState() {
    super.initState();
    DatabaseReference postReference = FirebaseDatabase.instance.reference().child("Post");
    postReference.once().then((DataSnapshot snap){
      var keys = snap.value.keys;
      var data = snap.value;

      carpostList.clear();
      
      for(var individualKey in keys){
        CarPost posts = CarPost(
          data[individualKey]['modelo'],
          data[individualKey]['marca'],
          data[individualKey]['image'],
          data[individualKey]['autoP'],
          data[individualKey]['numeroA'],
          data[individualKey]['psalida'],
          data[individualKey]['pactual'],
          data[individualKey]['year'],
          data[individualKey]['time'],
          data[individualKey]['date'],
        );
        carpostList.add(posts);
      }
      setState(() {
        print('Length: $carpostList.length');
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Foro"),
        ),
        body: Center(
          child: carpostList.length == 0
          ? Center(
            child: Text("No existen post"),
          )
          : Center(
            child: ListView.builder(
              itemCount: carpostList.length,
              itemBuilder: (_,index){
                return postUI(
                  carpostList[index].marca,
                  carpostList[index].modelo,
                  carpostList[index].imagen
                );
              },
            ),
          )
        ),
        floatingActionButton: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AgregarCarro()),
                  );
                },
                child: Icon(Icons.add),
              );
            }),
      ),
    );
  }

  Widget postUI(String marca,String modelo, String image){
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.all(14),
      child: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(marca),
                Text(modelo),
                Image.network(image,fit: BoxFit.cover,)
              ],
            )
          ],
        ),
      ),
    );
  }

  bool isSignIn = false;

  Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));

    _user = result.user;

    setState(() {
      isSignIn = true;
    });
  }

  Future<void> googleSignout() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      setState(() {
        isSignIn = false;
      });
    });
  }
}
