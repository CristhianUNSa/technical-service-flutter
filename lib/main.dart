import 'package:flutter/material.dart';
import 'package:technical_service_flutter/services/item-service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Technical Service',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.blueAccent,
      ),
      home: MyHomePage(title: 'Mi servicio técnico'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _serviceStatus = "";

  void changeStatus(string) {
    print("change status $string");
    setState(() {
      _serviceStatus = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyCustomForm(this.changeStatus),
            ],
          ),
        ),
        bottomSheet: Container(
            color: Color(0xFFB3E5FC),
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                        constraints: BoxConstraints(maxHeight: 200.0),
                        child: Column(children: <Widget>[
                          Icon(Icons.settings),
                          Text("Estado de su servicio:"),
                          Expanded(child: Text(_serviceStatus))
                        ]))),
              ],
            )));
  }
}

class MyCustomForm extends StatefulWidget {
  ItemService _itemService = new ItemService();
  Function changeStatus;

  MyCustomForm(this.changeStatus);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class. This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  String _orderNumber = "";

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                hintText: "Código de servicio",
                labelText: "Ingrese el código provisto por la secretaria"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor ingrese un valor correcto';
              }
            },
            onSaved: (input) {
              _orderNumber = input;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  widget.changeStatus(
                      widget._itemService.getStatus(_orderNumber));
                }
              },
              child: Text('Enviar'),
            ),
          ),
        ],
      ),
    );
  }
}
