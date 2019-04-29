import 'package:flutter/material.dart';
import 'package:technical_service_flutter/bloc/item_service_bloc.dart';
import 'package:technical_service_flutter/services/item_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
  ItemServiceBloc bloc;

  _MyHomePageState() {
    ItemService service = new ItemService();
    bloc = new ItemServiceBloc(serviceItemService: service);
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
              MyCustomForm(this.bloc),
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
                        constraints: BoxConstraints(maxHeight: 90.0),
                        child: Column(children: <Widget>[
                          Icon(Icons.settings),
                          Text("Estado de su servicio:"),
                          Expanded(
                            child: StreamBuilder(
                              stream: bloc.status,
                              initialData: "",
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return Text(
                                  "${snapshot.data}",
                                  style: TextStyle(fontSize: 40),
                                );
                              },
                            ),
                          )
                        ]))),
              ],
            )));
  }
}

class MyCustomForm extends StatefulWidget {
  final ItemServiceBloc bloc;

  MyCustomForm(this.bloc);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String _orderNumber = "";

  @override
  Widget build(BuildContext context) {
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
                  widget.bloc.getStatus(_orderNumber);
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
