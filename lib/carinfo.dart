import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Carinfo extends StatefulWidget {
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
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        height: 200,
                        width: 60,
                        padding: EdgeInsets.all(10),
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
                                    validator:(value){
                                        if(value.isEmpty){
                                          return "Ingrese un comentario antes!!";
                                        }
                                      },
                                    decoration: InputDecoration(
                                      hintText: "Comentario",
                                      prefixIcon: Icon(Icons.comment),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15)
                                      )
                                    ),
                                  )
                                ),
                                Container(
                                  child: RaisedButton(
                                    child: Text("Publicar"),
                                    onPressed: (){
                                      ComentarioToFireBase();
                                    }
                                    ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 300,
                        width: 60,
                        color: Colors.red,
                      ),
                    ]
                  ),      
                  ),
              ],
            )
            )
            );
  }

bool validateandSave(){
    final form = formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }


  void ComentarioToFireBase(){
    if(validateandSave()){
    var dbTimerKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');
    String date = formatDate.format(dbTimerKey);
    String time = formatTime.format(dbTimerKey);
    

    }
    


  }


}
