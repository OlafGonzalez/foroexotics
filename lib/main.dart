import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'agregarCarro.dart';
import 'Carpost.dart';
import 'carinfo.dart';

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
    DatabaseReference postReference =
    FirebaseDatabase.instance.reference().child("Post");
    postReference.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;

      carpostList.clear();

      for (var individualKey in keys) {
        CarPost posts = CarPost(
          individualKey,
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
        //print('Length: $carpostList.length');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: <Widget>[
            isSignIn
                ? Container(
                    width: 180,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(_user.photoUrl),
                        ),
                        Text(_user.displayName),
                        IconButton(
                          icon: Icon(Icons.exit_to_app),
                          onPressed: () {
                            googleSignout();
                          },
                        )
                      ],
                    ),
                  )
                : Container(
                    width: 65,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.person),
                            onPressed: () {
                              handleSignIn();
                            }),
                      ],
                    ),
                  )
          ],
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
                      itemBuilder: (_, index) {
                        return postUI(
                            carpostList[index].keyPost,
                            carpostList[index].marca,
                            carpostList[index].modelo,
                            carpostList[index].imagen,
                            carpostList[index].date,
                            carpostList[index].time,
                            carpostList[index].autoproducidos,
                            carpostList[index].precioActual,
                            carpostList[index].precioSalida,
                            carpostList[index].year,
                            carpostList[index].numeroAuto
                            );
                      },
                    ),
                  )
                  ),
        floatingActionButton: isSignIn
          ?
         StreamBuilder<Object>(
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
            })
          :
          FloatingActionButton.extended(
            label: Text("Iniciar Sesion"),
            icon: Icon(Icons.person),
            onPressed: (){
              handleSignIn();
          })
      ),
    );
  }

  Widget postUI(
      String keyPost,String marca, String modelo, String image, String date, String time,String autosproducidos,String precioActual,String precioSalida,String year,String numeroAuto) {
    return Card(
      elevation: 14.0,
      color: Colors.grey,
      margin: EdgeInsets.all(14),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text(date), Text(time)],
                ),
                Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
                Text(marca),
                Text(keyPost),
                StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return RaisedButton(
                      child: Text("info"), 
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) =>Carinfo(
                            usernameEnvio: _user.displayName,
                            imageuserEnvio: _user.photoUrl,
                            keyPostEnvio: keyPost,
                            marcaEnvio: marca,
                            modeloEnvio: modelo,
                            yearEnvio: year,
                            autosproducidosEnvio: autosproducidos,
                            precioActualEnvio: precioActual,
                            precioSalidaEnvio: precioSalida,
                            dateEnvio: date,
                            timeEnvio: time,
                            imagenEnvio: image,
                            numeroAutoEnvio: numeroAuto,
                          )
                          )
                          );

                    });
                  }
                ),
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
