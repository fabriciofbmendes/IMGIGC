import 'package:flutter/material.dart';
//Feito Por Fabricio Mendes e Guilherme Marques
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC e IGC',
      theme: ThemeData(
        primaryColor: Color(0xFF2196F3),
        accentColor: Color(0xFF2196F3),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Color(0xFF2196F3),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          subtitle1: TextStyle(
            color: Colors.grey[700],
            fontSize: 20.0,
          ),
          subtitle2: TextStyle(
            color: Colors.grey[700],
            fontSize: 18.0,
          ),
          bodyText2: TextStyle(
            color: Colors.grey[700],
            fontSize: 16.0,
          ),
          button: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF2196F3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            minimumSize: Size(150.0, 50.0),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: Color(0xFF2196F3),
            fontSize: 20.0,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF2196F3)),
          ),
        ),
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
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  TextEditingController idadeController = TextEditingController();
  String sexo = "M";
  double imc = 0;
  double igc = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC e IGC'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: idadeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Idade',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sexo: "),
                Radio(
                  value: "M",
                  groupValue: sexo,
                  onChanged: (value) {
                    setState(() {
                      sexo = value!;
                    });
                  },
                ),
                Text("Masculino"),
                Radio(
                  value: "F",
                  groupValue: sexo,
                  onChanged: (value) {
                    setState(() {
                      sexo = value!;
                    });
                  },
                ),
                Text("Feminino"),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  double peso = double.parse(pesoController.text);
                  double altura = double.parse(alturaController.text) / 100;
                  double idade = double.parse(idadeController.text);
                  imc = peso / (altura * altura);
                  igc = 1.2 * imc + 0.23 * idade - 10.8 * (sexo == "F" ? 1 : 0) - 5.4;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultadoPage(imc, igc),
                    ),
                  );
                });
              },
              child: Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultadoPage extends StatelessWidget {
  final double imc;
  final double igc;

  ResultadoPage(this.imc, this.igc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Seu IMC é ${imc.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Seu IGC é ${igc.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
