import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import './data.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
final scaffoldKey = GlobalKey<ScaffoldState>();

var coll = dataUserVariable().numberStudent;

int gett() {
  return coll = dataUserVariable().numberStudent;
}

class EditStudent extends StatefulWidget {
  int id;

  String dataJSpol;
  String dataJSname;
  String dataJSlastName;
  String dataJSage;
  String dataJSlevel;

  EditStudent(this.id, this.dataJSpol, this.dataJSname, this.dataJSlastName,
      this.dataJSage, this.dataJSlevel);

  @override
  State<StatefulWidget> createState() {
    int id2 = id;
    return EditStudentState(
        id, dataJSpol, dataJSname, dataJSlastName, dataJSage, dataJSlevel);
  }
}

class EditStudentState extends State<EditStudent> {
  String dataJSpol;
  String dataJSname;
  String dataJSlastName;
  String dataJSage;
  String dataJSlevel;

  int id;
  EditStudentState(this.id, this.dataJSpol, this.dataJSname,
      this.dataJSlastName, this.dataJSage, this.dataJSlevel);

  String locUserGender = '';
  String locUserName = '';
  String locUserLastName = '';
  String locUserAge = '';
  String locUserLevel = '';

  bool status = false;

  final TextEditingController _userGender = new TextEditingController();
  final TextEditingController _userName = new TextEditingController();
  final TextEditingController _userLastName = new TextEditingController();
  final TextEditingController _userAge = new TextEditingController();
  final TextEditingController _userLevel = new TextEditingController();
  String _statusLoadData = '';

  void saveBase() {
    int get = gett();
    database.reference().child('Ученик ${id + 1}').set({
      '1 Пол': '$locUserGender',
      '2 Имя': '$locUserName',
      '3 Фамилия': '$locUserLastName',
      '4 Возраст': '$locUserAge',
      '5 Успеваемость': '$locUserLevel'
    });

    status = true;
  }

  void _erase() {
    setState(() {
      _userGender.clear();
      _userName.clear();
      _userLastName.clear();
      _userAge.clear();
      _userLevel.clear();
    });
  }

  void _save() {
    setState(() {
      if (_userGender.text.isNotEmpty &&
          _userName.text.isNotEmpty &&
          _userLastName.text.isNotEmpty &&
          _userAge.text.isNotEmpty &&
          _userLevel.text.isNotEmpty) {
        locUserGender = _userGender.text;
        locUserName = _userName.text;
        locUserLastName = _userLastName.text;
        locUserAge = _userAge.text;
        locUserLevel = _userLevel.text;

        _statusLoadData = 'Saved';

        saveBase();
      } else {
        _statusLoadData = 'Пожалуйста заполните поля!';
      }
    });
  }

  void dataUserVariable() => dataUserVariable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Редактирование')),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            children: [
              TextField(
                controller: _userGender,
                decoration: InputDecoration(
                  hintText: 'Пол:                     $dataJSpol',
                  //icon: Icon(Icons.person),
                ),
              ),
              TextField(
                controller: _userName,
                decoration: InputDecoration(
                  hintText: 'Имя:                    $dataJSname',
                  //icon: Icon(Icons.person),
                ),
              ),
              TextField(
                controller: _userLastName,
                decoration: InputDecoration(
                  hintText: 'Фамилия:           $dataJSlastName',
                  //icon: Icon(Icons.person),
                ),
              ),
              TextField(
                controller: _userAge,
                decoration: InputDecoration(
                  hintText: 'Возраст:             $dataJSage',
                  //icon: Icon(Icons.person),
                ),
              ),
              TextField(
                controller: _userLevel,
                decoration: InputDecoration(
                  hintText: 'Успеваемость: $dataJSlevel',
                  //icon: Icon(Icons.person),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Row(
                    children: [],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_statusLoadData',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.save), title: Text('Сохранить')),
          BottomNavigationBarItem(
              icon: Icon(Icons.clear_all), title: Text('Очистить')),
        ],
        onTap: (int i) {
          if (i == 0) {
            _save();
          }
          if (i == 1) {
            _erase();
          }
        },
      ),
    );
  }
}
