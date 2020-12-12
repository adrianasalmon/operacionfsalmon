import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Operacion",
      home: Operacion(),
    );
  }
}
class Operacion extends StatefulWidget {
  Operacion({Key key}) : super(key: key);

  @override
  _OperacionState createState() => _OperacionState();
}

class _OperacionState extends State<Operacion> {
  String mensaje = "";
  final TextEditingController operacioncontroller = new TextEditingController();

  Future obtenerOperacion(String valor) async {
    print("entro a la funcion operacion");
      var response = await http.get(
      Uri.http("final2020.azurewebsites.net","/api/Operaciones?numero="+ valor));
    print(response.body);
    setState(() {
      mensaje=response.body;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         title: Text("OPERACION-ADRIANA",style: TextStyle(color: Colors.pink),),
         backgroundColor: Colors.white,
       ),
       backgroundColor: Colors.cyan,
       body: Column(
         children: [
           SizedBox(height:40.0),
          Container(
            padding: EdgeInsets.all(20.0),
              child: TextFormField(
            controller: operacioncontroller,
             decoration: InputDecoration(
               icon: Icon(IconData(58780, fontFamily: 'MaterialIcons'), color: Colors.white60),
               hintText: "Numero",
               hintStyle: TextStyle(color: Colors.white70)
             ),
          )),
          SizedBox(height:40.0),
          Text("Response: $mensaje", style: TextStyle(color: Colors.black)),
          SizedBox(height:20.0),
          RaisedButton(
            onPressed: () async {
              await obtenerOperacion(operacioncontroller.text);
            },
             padding: EdgeInsets.all(15.0),
             color: Colors.white,
             child: new Text("Boton", style: TextStyle(color: Colors.pink[300])) ,
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          )
         ],
       )
    );
  }
}