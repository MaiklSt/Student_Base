import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

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
  int _age;
  int _level;

  void saveBase() {
    database.reference().child('Ученик $_counter').set({
      '1 Пол': 'Мужской',
      '2 Имя': 'Валентин',
      '3 Фамилие': 'Валериевич',
      '4 Возраст': 18,
      '5 Успеваемость': 12
    });
    
    readBase();

  }

  void deleteBase() {
    database.reference().child('Ученик $_counter').remove();
    readBase();
  }

  void readBase() {
    database
        .reference()
        .child('Ученик $_counter')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> data = snapshot.value;

      setState(() {
        _downLoadStudent = _counter;
        if (data != null) {
          _pol = snapshot.value["1 Пол"];
          _name = snapshot.value['2 Имя'];
          _lastName = snapshot.value['3 Фамилие'];
          _age = snapshot.value['4 Возраст'];
          _level = snapshot.value['5 Успеваемость'];

          print(_pol);
          print(_name);
          print(_lastName);
          print(_age);
          print(_level);
        } else {
          _pol = 'null';
          _name = 'null';
          _lastName = 'null';
          _age = 0;
          _level = 0;
        }
      });
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter > _student) _counter--;
      readBase();
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      if (_counter < 0) _counter++;
      readBase();
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
              padding: EdgeInsets.all(100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Класс $_class',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                    //style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Ученик $_downLoadStudent',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                    //style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Пол $_pol',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                    //style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Имя $_name',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                    //style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Фамилия $_lastName',
                    style: TextStyle(
                      fontSize: 15.0,
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
