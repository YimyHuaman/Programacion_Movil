import 'package:flutter/material.dart';
void main()=>runApp(MyConvert());

class MyConvert extends StatefulWidget{
  @override
  //MyConvert({Key key}) : super(key: key)
  _MyConvertState createState()=> _MyConvertState();
}
class _MyConvertState extends State<MyConvert> {
final TextStyle labelStyle = TextStyle(fontSize: 24,color: Colors.black);
//datos dropdown 
final List<String> _datos=<String>['Metros','Kilometros','Gramos','Kilogramos','Pies','Millas','Libras','Onsas'];
final Map<String, int> _measuresMap = {
'meters': 0,
'kilometers': 1,
'grams': 2,
'kilograms': 3,
'feet': 4,
'miles': 5,
'pounds (lbs)': 6,
'ounces': 7,
};
final dynamic _formulas = {
'0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
'1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
'2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
'3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
'4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
'5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
'6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
'7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
};
String _vista='Seleccione una opcion';
//variables
 String? _resultMessage;
 String? _convertir;
 String? _start;
late double _numero;
@override
//inicializamos nuestro valor en 0
void initState() {
_numero = 0;
super.initState();
}
void convert(double value, String from, String to) {
int? nFrom = _measuresMap[from];
int? nTo = _measuresMap[to];
var multiplier = _formulas[nFrom.toString()][nTo];
double result = value * multiplier;
if (result == 0) {
_resultMessage = 'This conversion cannot be performed';
} else {
_resultMessage =
'${_numero.toString()} $_start are ${result.toString()
} $_convertir';
}
setState(() {
_resultMessage = _resultMessage;
});

}
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convertidor de Medidas',home: Scaffold(
        appBar: AppBar(title: Text('Convertidor de Medidas'),),
        body: Container(alignment: Alignment.center,
                        color: Colors.blue[50],
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child:Column(children: [ Text('Valor',style: labelStyle),
          TextField(decoration:InputDecoration(border: OutlineInputBorder(), labelText:"Por favor inserte la medida a convertir"),
          onChanged: (Text){
          var rv=double.tryParse(Text);
          if  (rv !=null){
            setState(() {
              _numero=rv;
            });
          }
        },),
            Spacer(),
          Text( 'De',style: labelStyle,),
           DropdownButton<String>(
             hint: Text(_vista),
             items:_datos.map<DropdownMenuItem<String>>(
               (String value ){
                  return DropdownMenuItem<String>(
                    value: value,
                    child:Text(value));
                  } ).toList(),
                    onChanged: (value){
                      setState(() {
                       _start =value;
                    });
               },
               value: _start,
             ),
          //II
          Spacer(),
          Text( 'A',style: labelStyle,),
        DropdownButton<String>(
             hint: Text(_vista),
             items:_datos.map<DropdownMenuItem<String>>(
               (String value ){
                  return DropdownMenuItem<String>(
                    value: value,
                    child:Text(value));
                  } ).toList(),
                    onChanged: (value){
                      setState(() {
                     _convertir =value;
                    });
               },
               value: _convertir,
             ),
          Spacer(flex:1),
          RaisedButton(highlightColor:Color.fromARGB(255, 255, 255, 56),color: Colors.blue,child: Text( 'Convertir'), onPressed:(){
          /* if(_start!.isEmpty|| _convertir!.isEmpty || _numero ==0){
              return;
            }else{
              convert(_numero, _start!, _convertir!);
            }*/
            
          }),
            Spacer(flex:2),
           Text((_resultMessage==null)?'':_resultMessage.toString(),style: labelStyle,),
           Spacer(flex:5),
        ],)  
        
        ),

      ),
    );
  }
}
