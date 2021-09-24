import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordcodegenerator/util/InputUpper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  flutterJs = getJavascriptRuntime();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

late JavascriptRuntime flutterJs;

class _MyAppState extends State<MyApp> {
  String _jsResult = '';
  String _jsResult2 = '';
  String _alpha = '';
  String _number = '';

  var _numbertocode = TextEditingController();
  var _codetonumber = TextEditingController();

  var _errortext = null;
  var _errortextnum = null;

  @override
  initState() {
    super.initState();
    name();
  }

  Future<void> name() async {
    String object = await rootBundle.loadString("assets/myclass.js");
    flutterJs.evaluate(object);
    setState(() {
      _alpha = flutterJs.evaluate("mClass.alphabets").stringResult;
      _number = flutterJs.evaluate("mClass.numbers").stringResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 18);
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CodeFinder'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: Text('Alphabets:-  $_alpha', style: textStyle)),
                  Center(
                      child: Text(
                    'Number:-     $_number',
                    style: textStyle,
                  )),
                  Center(
                      child:
                          Text('Code To Number:-  $_jsResult', style: textStyle)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      controller: _codetonumber,
                      onChanged: (v) {
                        if (v.length > 0) {
                          var stringResult2 = flutterJs
                              .evaluate("mClass.tonumbers('$v'.toUpperCase())")
                              .stringResult;

                          var stringResult3 = flutterJs
                              .evaluate("mClass.isAvstring('$v'.toUpperCase())")
                              .stringResult;
                          var err = (stringResult3 == "true")
                              ? null
                              : stringResult3.isEmpty
                                  ? null
                                  : "Please Enter correct alphabets";

                          setState(() {
                            _jsResult = stringResult2;
                            _errortext = err;
                          });
                        } else {
                          setState(() {
                            _jsResult = "";
                            _errortext = null;
                          });
                        }
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _errortext = null;
                              });
                              _clear(_codetonumber);
                            },
                            icon: Icon(Icons.clear, size: 28),
                          ),
                          border: OutlineInputBorder(),
                          hintText: '',
                          errorText: _errortext),
                    ),
                  ),
                  Center(
                      child:
                          Text('NumberTocode:-  $_jsResult2', style: textStyle)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _numbertocode,
                      onChanged: (v) {
                        // print(v);
                        if (v.length > 0) {
                          var stringResult2 = flutterJs
                              .evaluate("mClass.tostrings('$v')")
                              .stringResult;
                          var stringResult3 = flutterJs
                              .evaluate("mClass.isAvnumber('$v')")
                              .stringResult;
                          var err = (stringResult3 == "true")
                              ? null
                              : stringResult3.isEmpty
                                  ? null
                                  : "Please Enter Correct number";
                          setState(() {
                            _jsResult2 = stringResult2;
                            _errortextnum = err;
                          });
                        } else {
                          setState(() {
                            _jsResult2 = "";
                            _errortextnum = null;
                          });
                        }
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _errortextnum = null;
                              });
                              _clear(_numbertocode);
                            },
                            icon: Icon(Icons.clear, size: 28),
                          ),
                          border: OutlineInputBorder(),
                          hintText: '',
                          errorText: _errortextnum),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _clear(TextEditingController codetonumber) {
    codetonumber.text = "";
  }
}
