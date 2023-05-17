import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

main (){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giroscopio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(title: 'Proyecto 2 de AYED2'),
    );
  }
}

class MyHomePage extends StatefulWidget{
  String title;
  MyHomePage({Key? key, required this.title}):super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double dx = 155, dy = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<GyroscopeEvent>(
        //Aca se crea lo que lleva la aplicaioon dentro
        stream: SensorsPlatform.instance.gyroscopeEvents,//Hace como un import de los sensores necesarios, para utilizar el giroscopio
        builder: (_, snapshots){
          if(snapshots.hasData){
            dx = dx + snapshots.data!.y*10;
            dy = dy + snapshots.data!.x*10;
            print(dx/10);
            print(dy/10);
          }
          return Transform.translate(offset: Offset(dx,dy),//Establece la posicion del circulo
          child: const CircleAvatar(radius: 30,));//circulo que muestra el movimiento del giroscopio
        },
      ),
    );
  }
}
