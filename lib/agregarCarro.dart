import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AgregarCarro extends StatefulWidget {
  @override
  _AgregarCarroState createState() => _AgregarCarroState();
}

class _AgregarCarroState extends State<AgregarCarro> {
  File sampleImage;
  final formkey = GlobalKey<FormState>();

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
                Container(
                  padding:EdgeInsets.all(10),
                  child: sampleImage == null
                  ? Text("Sin imagen")
                  : enableUpload()
                  
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 90,
                      height: 40,
                      child: RaisedButton(
                        child: Text("photo"),
                        onPressed: (){
                          getImage();
                        }),
                    ),
                    Container(
                      width: 90,
                      height: 40,
                      child: RaisedButton(
                        child: Text("Add"),
                        onPressed: (){

                      }),
                    )
                  ],
                ),
                Container(
                  height: 20,
                )
              ],
            ),
          ))
        ],
      )),
    );
  }

  Widget enableUpload(){
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(
            sampleImage,
            height: 150,
            width: 300,
          ),
        ],
      ),
    );
  }

  Future getImage() async{
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

}
