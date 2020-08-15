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
          data[individualKey]['userName'],
          data[individualKey]['userImage'],
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
          data[individualKey]['ubicacion']
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
                            maxRadius: 16,
                            backgroundImage: NetworkImage(_user.photoUrl),
                          ),
                          Text(_user.displayName),
                          IconButton(
                            color: Colors.blueAccent,
                            icon: Icon(Icons.exit_to_app),
                            onPressed: () {
                              googleSignout();
                              setState(() {
                                isSignIn = false;
                              });
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
            title: Text("Exotics Cars"),
          ),
          body: Center(
              child: carpostList.length == 0
                  ? Center(
                      child: Text(
                        "No existen post",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  : Center(
                      child: ListView.builder(
                        itemCount: carpostList.length,
                        itemBuilder: (_, index) {
                          return postUI(
                              carpostList[index].userName,
                              carpostList[index].userImage,
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
                              carpostList[index].numeroAuto,
                              carpostList[index].ubicacion);
                        },
                      ),
                    )),
          floatingActionButton: isSignIn
              ? StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AgregarCarro(
                                    imageuserEnvio: _user.photoUrl,
                                    usernameEnvio: _user.displayName,
                                  )),
                        );
                      },
                      child: Icon(Icons.add),
                    );
                  })
              : FloatingActionButton.extended(
                  label: Text("Iniciar Sesion"),
                  icon: Icon(Icons.person),
                  onPressed: () {
                    handleSignIn();
                  })),
    );
  }

  Widget postUI(
      String userName,
      String userImage,
      String keyPost,
      String marca,
      String modelo,
      String image,
      String date,
      String time,
      String autosproducidos,
      String precioActual,
      String precioSalida,
      String year,
      String numeroAuto,
      String ubicacion) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(userImage),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          userName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          date,
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          time,
                          style: TextStyle(fontSize: 10),
                        ),
                        if(ubicacion != null)Text(
                          ubicacion,
                          style: TextStyle(fontSize: 10),
                        ),
                        Container(
                          height: 10,
                        )
                      ],
                    )
                  ],
                ),
                Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
                Text(
                  marca + " " + modelo,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      letterSpacing: 2),
                ),
                Text(
                  "No." +numeroAuto  + " de " + autosproducidos,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 1.2),
                ),
                StreamBuilder<Object>(
                    stream: null,
                    builder: (context, snapshot) {
                      return RaisedButton(
                          shape: StadiumBorder(),
                          child: Text(
                            "SPECS",
                            
                            style: TextStyle(
                              
                                color: Colors.blueAccent, letterSpacing: 1.8),
                          ),
                          onPressed: () {
                            if (isSignIn == false) {
                              showDialog(
                                  context: context,
                                  builder: (context) => Center(
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              height: 280,
                                              width: 300,
                                              padding: EdgeInsets.only(
                                                  top: 100,
                                                  bottom: 16,
                                                  left: 16,
                                                  right: 16),
                                              margin: EdgeInsets.only(top: 16),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(17),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black,
                                                        blurRadius: 10.0,
                                                        offset: Offset(0, 10))
                                                  ]),
                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(height: 16),
                                                  Text(
                                                      "Este contenido solo esta disponible para usuarios registrados",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        decoration:
                                                            TextDecoration.none,
                                                      )),
                                                  SizedBox(height: 24),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        RaisedButton(
                                                            color: Color(
                                                                0xff009688),
                                                            shape:
                                                                StadiumBorder(),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              "Confirmar",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                                      top: 0,
                                                      left: 16,
                                                      right: 16,
                                                      child: CircleAvatar(
                                                      backgroundImage: NetworkImage(image),
                                                      radius: 60, 
                                                      )
                                                      )
                                          ],
                                        ),
                                      ));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Carinfo(
                                            usernameEnvio: _user.displayName,
                                            imageuserEnvio: _user.photoUrl,
                                            keyPostEnvio: keyPost,
                                            marcaEnvio: marca,
                                            modeloEnvio: modelo,
                                            yearEnvio: year,
                                            autosproducidosEnvio:
                                                autosproducidos,
                                            precioActualEnvio: precioActual,
                                            precioSalidaEnvio: precioSalida,
                                            dateEnvio: date,
                                            timeEnvio: time,
                                            imagenEnvio: image,
                                            numeroAutoEnvio: numeroAuto,
                                          )));
                            }
                          });
                    }),
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
