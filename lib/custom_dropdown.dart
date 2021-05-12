import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {

  String currentValue;
  double borderRadius, ancho, alto;
  Color  textColor;
  Function cambioEstado ;
  List<String> valoresLista;

  CustomDropdown (
      this.valoresLista,
      this.currentValue,
      { required this.cambioEstado,
        this.alto = 40,
        this.ancho = 160,
        this.borderRadius = 20,
        this.textColor = Colors.black
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ancho,
      height: alto,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: DropdownButton(

        value: currentValue,
        iconSize: 16,
        elevation: 8,
        style: TextStyle(
          color: textColor,
        ),
        onChanged: (algo){
          this.cambioEstado(algo);
        },
        items: valoresLista.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
