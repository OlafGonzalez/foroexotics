import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foroexotics/main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';


class AgregarCarro extends StatefulWidget {
  @override
  _AgregarCarroState createState() => _AgregarCarroState();
}

class _AgregarCarroState extends State<AgregarCarro> {
  File sampleImage;
  String modelo,marca,year,autoP,numeroA,psalida,pactual,url;
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
            key: formkey,
            child: Center(
              child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    onSaved: (value) => modelo = value,
                    validator: (value){
                      if(value.isEmpty){
                        return "Ingrese el modelo";
                      }
                    },
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
                    onSaved: (value) => marca = value,
                    validator: (value){
                      if(value.isEmpty){
                        return "Ingrese la marca";
                      }
                    },
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
                    onSaved: (value) => year = value,
                    validator: (value){
                      if(value.isEmpty){
                        return "Ingrese el ano";
                      }
                    },
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
                    onSaved: (value) => autoP = value,
                    validator: (value){
                      if(value.isEmpty){
                        return "Ingrese el numero de autos producidos";
                      }
                    },
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
                    onSaved: (value) => numeroA = value,
                    validator: (value){
                      if(value.isEmpty){
                        return "Ingrese el numero del auto";
                      }
                    },
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
                    onSaved: (value) => psalida = value,
                    validator: (value){
                      if(value.isEmpty){
                        return "Ingrese el precio de salida";
                      }
                    },
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
                    onSaved: (value) => pactual = value,
                    validator: (value){
                      if(value.isEmpty){
                        return "Ingrese el precio actual";
                      }
                    },
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
                          uploadStatusImage();
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

  void uploadStatusImage() async {
    if(validateandSave()){
      //subir a firestorage
      final StorageReference postImage = FirebaseStorage.instance.ref().child("Autos photos");
      var timekey = DateTime.now();
      final StorageUploadTask uploadTask = postImage.child(timekey.toString() + ".jpg").putFile(sampleImage);
      var imageURL = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageURL.toString();
      print("URL image: " + url);

      saveToDatabase(url);
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context){
          return MyApp();
        } 
        ));

    }
  }
  void saveToDatabase(String url){
    var dbTimerKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimerKey);
    String time = formatTime.format(dbTimerKey);
    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data = {
      "image":url,
      "modelo":modelo,
      "marca":marca,
      "year":year,
      "autoP":autoP,
      "numeroA":numeroA,
      "psalida":psalida,
      "pactual":pactual,
      "date":date,
      "time":time
    };
  ref.child("Post").push().set(data);

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
