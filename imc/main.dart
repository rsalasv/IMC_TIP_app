import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  var heightController = TextEditingController();
  var weightController = TextEditingController();
  bool gen = true;
  double imc = 0;
  var tabla;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora IMC'),
      ),
      body: ListView(children: [
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Column(
              children:[
                Text("Ingrese sus datos para calcular IMC"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                      setState(() {
                        gen = false;
                      });
                    }, 
                      icon: Icon(Icons.male),
                      color: !gen ? Colors.blue: Colors.grey,  
                    ),

                    SizedBox(width: 50),
                    IconButton(onPressed: (){
                      setState(() {
                        gen = true;
                      });
                    }, 
                      icon: Icon(Icons.female),
                      color: gen ? Colors.pink: Colors.grey,  
                    ),
                  ],
                )
              ]
            )
          ]
        ),
        SizedBox(height: 5),
        ListTile(
            leading: Icon(Icons.square_foot),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  ),
                  labelText: "Ingresar altura (Metros)",
                  //errorText: validate ? true: ,
                )
              ),
            ),
          ),
          SizedBox(height: 5),
          ListTile(
            leading: Icon(Icons.monitor_weight),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  ),
                  labelText: "Ingresar peso (KG)",
                  //errorText: validate ? true: ,
                )
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: MaterialButton(
                    child:  Text("Calcular"),
                    onPressed: (){
                      if(weightController.text.isNotEmpty && heightController.text.isNotEmpty){
                        if(gen)
                          tabla = "Tabla del IMC para MUJERES \n\nEdad   IMC ideal\n16-17  19-24\n18-18  19-24\n19-24  19-24\n25-34 20-25\n35-44 21-26\n45-54 22-27\n55-64 22-27\n55-64 23-28\n65-90 25-30";
                        else
                          tabla = "Tabla del IMC para HOMBRES \n\nEdad   IMC ideal\n16-17  19-24\n18-18  19-24\n19-24  19-24\n25-34 20-25\n35-44 21-26\n45-54 22-27\n55-64 22-27\n55-64 23-28\n65-90 25-30";
                        imc = (double.parse(weightController.text) / (double.parse(heightController.text)*double.parse(heightController.text)));
                        imc = double.parse(imc.toStringAsFixed(2));
                        showDialog(
                          context: context, 
                          builder: (context) => AlertDialog(
                            title: Text("Tu IMC: $imc"),
                            content: Text("$tabla"),
                            actions: [
                              TextButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                }, 
                                child: Text("Entendido", 
                                        style: TextStyle(color: Colors.black))),
                            ],
                          )
                        );
                      }
                      else
                        showDialog(
                          context: context, 
                          builder: (context) => AlertDialog(
                            title: Text("Error"),
                            content: Text("Por favor rellena todos los campos"),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                              }, 
                              child: Text("Entendido",
                                      style: TextStyle(color: Colors.black),))
                            ],
                          )
                        );
                    },),
                )
              )
              
            ],
          )
      ],
        ),
      );
    
  }
}