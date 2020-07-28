import 'package:flutter/material.dart';

class Carinfo extends StatefulWidget {
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

  const Carinfo({
    Key key, 
    this.marcaEnvio, 
    this.modeloEnvio, 
    this.imagenEnvio, 
    this.dateEnvio, 
    this.timeEnvio, 
    this.autosproducidosEnvio, 
    this.precioActualEnvio, 
    this.precioSalidaEnvio, 
    this.yearEnvio, 
    this.numeroAutoEnvio
    }) : super(key: key);

 
  @override
  _CarinfoState createState() => _CarinfoState(marcaEnvio,modeloEnvio,imagenEnvio,dateEnvio,timeEnvio,autosproducidosEnvio,precioActualEnvio,precioSalidaEnvio,yearEnvio,numeroAutoEnvio);
}

class _CarinfoState extends State<Carinfo> {
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
          body: Column(
            children: <Widget>[
              Container(
                //Info Post
                height: 300,
                width: 700,
                color: Colors.lightBlue,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(3),
                      child: Image.network(imagenRecibe),
                    ),
                    //Modelo
                    Container(
                      child: Text(modeloRecibe),
                    )
                  ],
                ),

              ),
              //Comentarios
              Container(

              )

            ],
          ),
        )
        );
  }
}
