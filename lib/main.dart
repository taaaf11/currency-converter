import 'dart:convert';

import 'package:currency_conv/components/dollar_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/currency_dropdowns.dart';
import 'notifiers.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FromCurrencyProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ToCurrencyProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Currency Converter App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff3c867d), brightness: Brightness.dark),
          useMaterial3: true,
          fontFamily: 'Comfortaa',
        ),
        home: const MyHomePage(title: 'Currency Converter'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController fromTextEditingController;

  String _converted = '';
  double rate = 0;
  bool isConvertedVisible = false;

  Future<double> _fetchRate(String fromCode, String toCode) async {
    var uri = Uri.parse('https://open.er-api.com/v6/latest/$fromCode');
    var response = await http.get(uri);
    var responseJson = jsonDecode(response.body);

    var rates = responseJson['rates'];
    double requiredRate = rates[toCode]!;
    return requiredRate;
  }

  @override
  void initState() {
    fromTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    fromTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var fromState = Provider.of<FromCurrencyProvider>(context);
    var toState = Provider.of<ToCurrencyProvider>(context);

    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: screenWidth <= 640 ? 50 : 0),
          child: Card(
            color: const Color(0xff000000),
            borderOnForeground: true,
            child: SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    const DollarBox(),
                    //
                    const SizedBox(height: 40),
                    //
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'From:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 150,
                          child:
                              TextField(controller: fromTextEditingController),
                        ),
                        // const SizedBox(width: 20),
                        const FromCurrencyDropdown()
                      ],
                    ),
                    //
                    const SizedBox(height: 40),
                    const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'To:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 20),
                          ToCurrencyDropdown()
                        ],
                      ),
                    ),
                    //
                    const SizedBox(height: 40),
                    //
                    ElevatedButton(
                      onPressed: () async {
                        rate = await _fetchRate(
                            fromState.current, toState.current);
                        setState(
                          () {
                            double value =
                                double.parse(fromTextEditingController.text);
                            double result = value * rate;
                            _converted = result.toStringAsFixed(2);
                            isConvertedVisible = true;
                          },
                        );
                      },
                      child: const Text('Convert!'),
                    ),
                    //
                    const SizedBox(height: 20),
                    Visibility(
                      visible: isConvertedVisible,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Text(_converted),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
