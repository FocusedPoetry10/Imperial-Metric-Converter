import 'package:flutter/material.dart';
import 'conversion.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double value = 0;
  String fromUnit = 'inches';
  String toUnit = 'centimeters';

  void setConversionMeasurements(String category) {
    switch (category) {
      case 'Length':
        fromUnit = 'inches';
        toUnit = 'centimeters';
        break;
      case 'Volume':
        fromUnit = 'teaspoons';
        toUnit = 'teaspoons';
        break;
      case 'Weight and Mass':
        fromUnit = 'ounces';
        toUnit = 'grams';
        break;
      case 'Temperature':
        fromUnit = 'celsius';
        toUnit = 'fahrenheit';
        break;
      case 'Area':
        fromUnit = 'square inches';
        toUnit = 'square centimeters';
        break;
    }
  }

  void handleButtonPress(String label) {
    setState(() {
      switch (label) {
        case 'CE':
          value = 0;
          break;
        case 'X':
          if (value != 0) {
            value = (value ~/ 10).toDouble();
          }
          break;
        case '+/-':
          value = -value;
          break;
        case '.':
          if (!value.toString().contains('.')) {
            value = double.parse(value.toString() + label);
          }
          break;
        default:
          if (label != '+/-') {
            value = value * 10 + double.parse(label);
          }
      }
    });
  }

  Widget buildNumberPad() {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: buildNumberRow(['CE', 'X', '+/-']),
          ),
          Expanded(
            child: buildNumberRow(['7', '8', '9']),
          ),
          Expanded(
            child: buildNumberRow(['4', '5', '6']),
          ),
          Expanded(
            child: buildNumberRow(['1', '2', '3']),
          ),
          Expanded(
            child: buildNumberRow(['0', '.']),
          ),
        ],
      ),
    );
  }

  Widget buildNumberRow(List<String> labels) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: labels.map((label) => buildNumberButton(label)).toList(),
    );
  }

  Widget buildNumberButton(String label) {
    Color? bgColor;
    double fontSize = 24;

    if (label == 'CE' || label == 'X' || label == '+/-') {
      bgColor = Color(0xFFF392F0).withOpacity(0.4);
    } else if (label == '.') {
      bgColor = Color(0xFFB4C7FF).withOpacity(0.6);
    } else if (label == '9' || label == '8' || label == '7' || label == '6' || label == '5' || label == '4' || label == '3' || label == '2' || label == '1' || label == '0') {
      bgColor = Color(0xFFB4C7FF).withOpacity(0.6);
    } else {
      bgColor = Theme.of(context).primaryColor;
      fontSize = 18; // Font size for options
    }

    return Expanded(
      child: InkWell(
        onTap: () {
          handleButtonPress(label);
        },
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bgColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Color(0xFF363636),
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imperial to Metric Converter'),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFFB4C7FF).withOpacity(0.6),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Length',
                  style: TextStyle(color: Color(0xFF363636), fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  setConversionMeasurements('Length');
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              ListTile(
                title: Text(
                  'Volume',
                  style: TextStyle(color: Color(0xFF363636), fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  setConversionMeasurements('Volume');
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              ListTile(
                title: Text(
                  'Weight and Mass',
                  style: TextStyle(color: Color(0xFF363636), fontSize: 20, fontWeight: FontWeight.bold)),
                onTap: () {
                  setConversionMeasurements('Weight and Mass');
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              ListTile(
                title: Text(
                  'Temperature',
                  style: TextStyle(color: Color(0xFF363636), fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  setConversionMeasurements('Temperature');
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              ListTile(
                title: Text(
                  'Area',
                  style: TextStyle(color: Color(0xFF363636), fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  setConversionMeasurements('Area');
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Settings',
                  style: TextStyle(color: Color(0xFF363636), fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                },
              ),
              ListTile(
                title: Text(
                  'Send Feedback',
                  style: TextStyle(color: Color(0xFF363636), fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  sendFeedback();
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/27506966_7343142.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Value',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: '',
                      ),
                      controller: TextEditingController(text: value.toString()),
                      onChanged: (text) {
                        value = double.tryParse(text) ?? 0;
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          value: fromUnit,
                          items: (ConversionService.isLengthCategory(fromUnit, toUnit)
                                  ? ConversionService.lengthConversionFactors
                                  : (ConversionService.isVolumeCategory(fromUnit, toUnit)
                                      ? ConversionService.volumeConversionFactors
                                      : (ConversionService.isTemperatureCategory(fromUnit, toUnit)
                                          ? ConversionService.temperatureConversionFactors
                                          : (ConversionService.isAreaCategory(fromUnit, toUnit)
                                              ? ConversionService.areaConversionFactors
                                              : ConversionService.weightConversionFactors))))
                              .keys
                              .map((unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(
                                      unit,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              fromUnit = newValue!;
                            });
                          },
                        ),
                        DropdownButton<String>(
                          value: toUnit,
                          items: (ConversionService.isLengthCategory(fromUnit, toUnit)
                                  ? ConversionService.lengthConversionFactors
                                  : (ConversionService.isVolumeCategory(fromUnit, toUnit)
                                      ? ConversionService.volumeConversionFactors
                                      : (ConversionService.isTemperatureCategory(fromUnit, toUnit)
                                          ? ConversionService.temperatureConversionFactors
                                          : (ConversionService.isAreaCategory(fromUnit, toUnit)
                                              ? ConversionService.areaConversionFactors
                                              : ConversionService.weightConversionFactors))))
                              .keys
                              .map((unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(
                                      unit,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              toUnit = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text('Convert'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Result',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${value.toStringAsFixed(2)} $fromUnit = ${ConversionService.convert(value, fromUnit, toUnit).toStringAsFixed(2)} $toUnit',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: buildNumberPad(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendFeedback() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'vinee3700@gmail.com', // Replace with your email address
      queryParameters: {'subject': 'Feedback for Imperial to Metric Converter App'},
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch email client';
    }
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Calculator',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Imperial to Metric System Converter App v1.0.0',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Developed by: VVSM Team',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Developed on: February 28, 2024',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
