import 'package:excel/excel.dart';
import 'package:excel_test/custom_dropdown.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show ByteData, rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget dataComponents () {

    List<Widget> values =  [];

    excelData.forEach((element) {
      values.add(
        Container(
          width: 300,
              child: Text('${excelData.indexOf(element)}.  $element'))
        );
    });

    return Container(
      height: 400,
      width: 300,
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: values,
          ),
        ),
      ),
    );
  }

  List <String> excelData = ['Election....'];
  String category = 'Election....', currentOption = 'Election....';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Excel test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            CustomDropdown(
                [
                  'Election....',
                  'Ambulancias',
                  'Automóviles',
                  'Camionetas',

                  'Doble cabina',
                ],
                category,
                cambioEstado: (value){
                  if (value != 'Election....') {
                    category = value;
                    _getData().then((read) {
                      setState(() {
                        excelData = read;
                        print(excelData);
                      });
                    });
                  } else {

                  }
                }
            ),

            SizedBox(height: 30,),
            dataComponents(),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

 Future <List <String>> _getData () async {

    List <String> dataRead = [];
    ByteData data = await rootBundle.load("assets/categorias_vehiculos.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes,);

     excel[category].rows[0].forEach((element) {
       if (element?.value != null) {
         dataRead.add(element?.value);
       }
     });

     dataRead.sort();
     dataRead.insert(0, 'Election....');
    return dataRead;

  }
}

