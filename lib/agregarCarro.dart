import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foroexotics/main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';


class AgregarCarro extends StatefulWidget {
  final String usernameEnvio;
  final String imageuserEnvio;

  const AgregarCarro({
  Key key, 
  this.usernameEnvio, 
  this.imageuserEnvio}) : super(key: key);
  @override
  _AgregarCarroState createState() => _AgregarCarroState(usernameEnvio,imageuserEnvio);
}

class _AgregarCarroState extends State<AgregarCarro> {
  final String usernameRecibe;
  final String imageuserRecibe;
  File sampleImage;
  String modelo,marca,year,autoP,numeroA,psalida,pactual,url,ubicacion;
  final formkey = GlobalKey<FormState>();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  final myUbicacionController = TextEditingController();

  Position _currentPosition;
  String _currentAddress;
  String result = '';

  _AgregarCarroState(this.usernameRecibe, this.imageuserRecibe);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar exótico"),
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
                        prefixIcon: Icon(Icons.time_to_leave),
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
                        prefixIcon: Icon(Icons.time_to_leave),
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
                        return "Ingrese el año";
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Año",
                        prefixIcon: Icon(Icons.calendar_today),
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
                        return "Ingrese el número de autos producidos";
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Autos producidos",
                        prefixIcon: Icon(Icons.gavel),
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
                        hintText: "Número de auto",
                        prefixIcon: Icon(Icons.directions_car),
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
                        prefixIcon: Icon(Icons.attach_money),
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
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: myUbicacionController,
                    //initialValue: _currentAddress,
                    onSaved: (value) => ubicacion = value,
                    validator: (value){
                      if(value.isEmpty){
                        return "Ingrese la direccion";
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Ubicacion",
                        prefixIcon: Icon(Icons.map),
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
                      
                      child: RaisedButton(
            
                        shape: StadiumBorder(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.camera_alt),
                            Text("Subir Foto",style: TextStyle(
                                    color: Colors.blueAccent, letterSpacing: 1.8),),
                          ],
                        ),
                        onPressed: (){
                          getImage();
                        }),
                    ),
                    Container(
                     
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.location_on),
                            Text("Ubicación",style: TextStyle(
                                    color: Colors.blueAccent, letterSpacing: 1.8),
                                    ),
                          ],
                        ),
                        onPressed: (){
                           _getCurrentLocation();
                      }),
                    ),
                    Container(
                     
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.file_upload),
                            Text("Subir",style: TextStyle(
                                    color: Colors.blueAccent, letterSpacing: 1.8),
                                    ),
                          ],
                        ),
                        onPressed: (){
                          if(sampleImage == null){
                            _showDialog();
                          }else{
                          uploadStatusImage();
                          }
                      }),
                    ),
                    
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
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("No se puede realizar esta accion"),
          content: new Text("Agrege una imagen"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
 _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        myUbicacionController.text =
            "${place.locality}, ${place.subLocality}, ${place.country}";

      });
    } catch (e) {
      print(e);
    }
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
      "userName":usernameRecibe,
      "userImage":imageuserRecibe,
      "image":url,
      "modelo":modelo,
      "marca":marca,
      "year":year,
      "autoP":autoP,
      "numeroA":numeroA,
      "psalida":psalida,
      "pactual":pactual,
      "date":date,
      "time":time,
      "ubicacion":ubicacion
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
