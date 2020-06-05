import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter Student',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Data Student'),
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
  int _class = 11;
  int _student = 20;
  int _downLoadStudent = 0;
  int _counter = 0;

  String _pol = '';
  String _name = '';
  String _lastName = '';
  int _vozrast;
  int _uspevaemost;

  void saveBase() {
    database.reference().child('Ученик $_counter').set({
      '1 Пол': 'Мужской',
      '2 Имя': 'Валентин',
      '3 Фамилие': 'Валериевич',
      '4 Возраст': 18,
      '5 Успеваемость': 12
    });
  }

  void deleteBase() {
    database.reference().child('Ученик $_counter').remove();
  }

  void readBase() {
    
    setState(() {
      _downLoadStudent = _counter;
    });

    //database.reference().child('Ученик 0').once().then((value) => null);
    database.reference().child('Ученик $_counter').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> data = snapshot.value;
      print('Класс 11 Ученик $_counter ${data.values}');

    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter > _student) _counter--;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      if (_counter < 0) _counter++;
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
          children: [
            Container(
              padding: EdgeInsets.all(130.0),
              child: Column(
                children: [
                  Text(
                    'Класс $_class',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    //style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Ученик $_downLoadStudent',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    //style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Пол $_downLoadStudent',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    //style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Set id Student ',
                      // style: TextStyle(
                      //   fontSize: 20.0,
                      // ),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      child: Text('Save'),
                      color: Colors.redAccent,
                      onPressed: () {
                        saveBase();
                      },
                    ),
                    FlatButton(
                      child: Text('Read'),
                      color: Colors.redAccent,
                      onPressed: () {
                        readBase();
                      },
                    ),
                    FlatButton(
                      child: Text('Delete'),
                      color: Colors.redAccent,
                      onPressed: () {
                        deleteBase();
                      },
                    ),
                    Column(
                      children: [
                        FlatButton(
                          child: Text('UP'),
                          color: Colors.redAccent,
                          onPressed: () {
                            _incrementCounter();
                          },
                        ),
                        FlatButton(
                          child: Text('DOWN'),
                          color: Colors.redAccent,
                          onPressed: () {
                            _decrementCounter();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
