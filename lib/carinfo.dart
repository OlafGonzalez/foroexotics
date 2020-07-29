import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foroexotics/Comentarios.dart';
import 'package:intl/intl.dart';

class Carinfo extends StatefulWidget {
  final String usernameEnvio;
  final String imageuserEnvio;
  final String keyPostEnvio;
  final String marcaEnvio;
  final String modeloEnvio;
  final String imagenEnvio;
  final String dateEnvio;
  final String timeEnvio;
  final String autosproducidosEnvio;
  final String precioActualEnvio;
  final String precioSalidaEnvio;
  final String yearEnvio;
  final String numeroAutoEnvio;

  const Carinfo(
      {Key key,
      this.usernameEnvio,
      this.imageuserEnvio,
      this.keyPostEnvio,
      this.marcaEnvio,
      this.modeloEnvio,
      this.imagenEnvio,
      this.dateEnvio,
      this.timeEnvio,
      this.autosproducidosEnvio,
      this.precioActualEnvio,
      this.precioSalidaEnvio,
      this.yearEnvio,
      this.numeroAutoEnvio})
      : super(key: key);

  @override
  _CarinfoState createState() => _CarinfoState(
      usernameEnvio,
      imageuserEnvio,
      keyPostEnvio,
      marcaEnvio,
      modeloEnvio,
      imagenEnvio,
      dateEnvio,
      timeEnvio,
      autosproducidosEnvio,
      precioActualEnvio,
      precioSalidaEnvio,
      yearEnvio,
      numeroAutoEnvio);
}

class _CarinfoState extends State<Carinfo> {
  String _comentario;
  final formkey = GlobalKey<FormState>();
  List<Comentarios> comentariosList = [];
  final String usernameRecibe;
  final String imageuserRecibe;
  final String keyPostRecibe;
  final String marcaRecibe;
  final String modeloRecibe;
  final String imagenRecibe;
  final String dateRecibe;
  final String timeRecibe;
  final String autosproducidosRecibe;
  final String precioActualRecibe;
  final String precioSalidaRecibe;
  final String yearRecibe;
  final String numeroAutoRecibe;

  _CarinfoState(
      this.usernameRecibe,
      this.imageuserRecibe,
      this.keyPostRecibe,
      this.marcaRecibe,
      this.modeloRecibe,
      this.imagenRecibe,
      this.dateRecibe,
      this.timeRecibe,
      this.autosproducidosRecibe,
      this.precioActualRecibe,
      this.precioSalidaRecibe,
      this.yearRecibe,
      this.numeroAutoRecibe);

  @override
  void initState() {
    super.initState();
    DatabaseReference postReference = FirebaseDatabase.instance
        .reference()
        .child("/comentarios/" + keyPostRecibe + "");
    postReference.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      comentariosList.clear();

      for (var comentsKeys in keys) {
        Comentarios comen = Comentarios(
            data[comentsKeys]['date'],
            data[comentsKeys]['time'],
            data[comentsKeys]['comentario'],
            data[comentsKeys]['userNombre'],
            data[comentsKeys]['userImagen']);
        comentariosList.add(comen);
      }
      setState(() {
        print('Length: $comentariosList.length');
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
                Container(
                  width: 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(imageuserRecibe),
                      ),
                      Text(usernameRecibe),
                    ],
                  ),
                )
              ],
              title: Text("Info"),
            ),
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  //title: Text(modeloRecibe),
                  backgroundColor: Colors.grey,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(modeloRecibe),
                    background: Image.network(
                      imagenRecibe,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      height: 170,
                      width: 60,
                      padding: EdgeInsets.all(1),
                      //color: Colors.yellow,
                      child: Form(
                        key: formkey,
                        child: Card(
                          elevation: 10.0,
                          child: Column(
                            children: <Widget>[
                              Container(
                                  //TextFormfield comentario
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    onSaved: (value) => _comentario = value,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Ingrese un comentario antes!!";
                                      }
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Comentario",
                                        prefixIcon: Icon(Icons.comment),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                  )),
                              Container(
                                child: RaisedButton(
                                    child: Text("Publicar"),
                                    onPressed: () {
                                      ComentarioToFireBase(keyPostRecibe);
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                SliverList(
                    delegate: SliverChildListDelegate(
                        List.generate(comentariosList.length, (index) {
                  return cardComen(
                      comentariosList[index].comentario,
                      comentariosList[index].date,
                      comentariosList[index].time,
                      comentariosList[index].userName,
                      comentariosList[index].userImage);
                })))
              ],
            )));
  }

  Widget cardComen(String comentario, String date, String time, String userName,
      String userImage) {
    return Card(
      elevation: 14.0,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 18,
                  backgroundImage: NetworkImage(imageuserRecibe),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //UserName
                Container(
                  width:290 ,
                  child: 
                  Text(
                    userName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),),
                ),
                //Comentario
                Container(
                  width: 290,
                  child: Text(comentario,
                  style: TextStyle(

                    fontSize: 16
                  ),
                  ),
                ),
                Container(
                  height: 10,
                ),

                Container(
                  width: 290,
                  child: Text(date +" "+ time,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                Container(
                  width: 290,
                  child: Text("Sign in whit Google",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold
                  ),),
                  
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validateandSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void ComentarioToFireBase(String keypost) {
    if (validateandSave()) {
      var dbTimerKey = DateTime.now();
      var formatDate = DateFormat('MMM d, yyyy');
      var formatTime = DateFormat('EEEE, hh:mm aaa');
      String date = formatDate.format(dbTimerKey);
      String time = formatTime.format(dbTimerKey);
      DatabaseReference ref = FirebaseDatabase.instance.reference();
      var data = {
        "date": date,
        "time": time,
        "comentario": _comentario,
        "userNombre": usernameRecibe,
        "userImagen": imageuserRecibe
      };
      ref.child("/comentarios/" + keypost + "").push().set(data);
    }
  }
}
