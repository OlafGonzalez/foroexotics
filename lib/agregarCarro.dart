import 'package:flutter/material.dart';

class AgregarCarro extends StatefulWidget {
  @override
  _AgregarCarroState createState() => _AgregarCarroState();
}

class _AgregarCarroState extends State<AgregarCarro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar exotico"),
      ),
      body: Center(
          child: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Form(
            child: Center(
              child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Modelo",
                        prefixIcon: Icon(Icons.card_travel),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                //Marca
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Marca",
                        prefixIcon: Icon(Icons.card_travel),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Ano",
                        prefixIcon: Icon(Icons.card_travel),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Autos producidos",
                        prefixIcon: Icon(Icons.card_travel),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Numero de auto",
                        prefixIcon: Icon(Icons.card_travel),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Precio de salida",
                        prefixIcon: Icon(Icons.card_travel),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Precio actual",
                        prefixIcon: Icon(Icons.card_travel),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 90,
                      height: 40,
                      child: RaisedButton(
                        child: Text("Add"),
                        onPressed: (){

                      }),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      )),
    );
  }
}
