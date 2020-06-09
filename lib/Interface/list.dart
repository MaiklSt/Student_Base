import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import './CreatStudent.dart';
import './view.dart';
import './data.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

var dataJSpol = [];
var dataJSname = [];
var dataJSlastName = [];
var dataJSage = [];
var dataJSlevel = [];

String locUserGender = '';
String locUserName = '';
String locUserLastName = '';
String locUserAge = '';
String locUserLevel = '';

int numBaseData = 0;

class Variables {
  int xxx = 0;

  int fff = 0;

  int status = 0;

  bool saved = false;

  int Buff;

  void JEST(int label) {
    Buff = label;
  }

  void CLS() {
    dataJSpol.clear();
    dataJSname.clear();
    dataJSlastName.clear();
    dataJSage.clear();
    dataJSlevel.clear();
  }
}

class ListData extends StatefulWidget {
  ListData({Key key, this.title}) : super(key: key);

  final String title;

  int RET() {
    var x = Variables().JEST(numBaseData);
    return numBaseData;
  }

  @override
  _ListData createState() => _ListData();
}

class _ListData extends State<ListData> {
  bool listStatus = false;
  bool startStatus = true;

  bool perehod = false;

  void createStudent() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CreatStudent(numBaseData);
        },
      ),
    );
  }

  void listData() async {
    if (listStatus == true || startStatus == true) {
      Variables().CLS();

      listStatus = false;
      startStatus = false;

      await database
          .reference()
          .child('Количество')
          .once()
          .then((DataSnapshot snapshot) {
        numBaseData = snapshot.value["coll"];
      
      });

      for (int x = 0; x < numBaseData; x++) {
        database
            .reference()
            .child('Ученик $x')
            .once()
            .then((DataSnapshot snapshot) {
          setState(() {
            dataJSpol.add(snapshot.value["1 Пол"]);
            dataJSname.add(snapshot.value["2 Имя"]);
            dataJSlastName.add(snapshot.value["3 Фамилия"]);
            dataJSage.add(snapshot.value["4 Возраст"]);
            dataJSlevel.add(snapshot.value["5 Успеваемость"]);
            //sleep(const Duration(seconds: 3));
          });
        });
      }
    }
  }

  Future<bool> status(int num) async {
    bool res;

    Variables().CLS();
    await database
        .reference()
        .child('Ученик $num')
        .once()
        .then((DataSnapshot snapshot) {
      res = snapshot.value["1 Пол"];
      print('resssssssssssssssssssssssssss   $res');
    });

    if (res != null)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    listData();

    return SafeArea(
      child: Scaffold(
//        appBar: AppBar(
//          title: Text('TEST'),                  // appBar on/off
//          backgroundColor: Colors.black,
//        ),
        backgroundColor: Colors.grey[200],
        body: new ListView.builder(
            itemCount: dataJSpol.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (BuildContext context, int position) {
              //listData();
              final index = position;

              return Card(
                color: Colors.white70,
                child: new ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                            color: Colors.white60,
                            child: Text(
                              'Студент $index',
                              style: new TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      new Text(
                        'Пол                     ${dataJSpol[index]}',
//                          'Пол          ${dataJSpol[1]}',
                        style: new TextStyle(
                            fontSize: 19.5,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500),
                      ),
                      new Text(
                        'Имя                    ${dataJSname[index]}',
//                          'Имя          ${dataJSname[1]}',
                        style: new TextStyle(
                            fontSize: 19.5,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500),
                      ),
                      new Text(
                        'Фамилия           ${dataJSlastName[index]}',
//                          'Фамилия     ${dataJSlastName[1]}',
                        style: new TextStyle(
                            fontSize: 19.5,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500),
                      ),
                      new Text(
                        'Возраст             ${dataJSage[index]}',
//                          'Возраст      ${dataJSage[1]}',
                        style: new TextStyle(
                            fontSize: 19.5,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500),
                      ),
                      new Text(
                        'Успеваемость ${dataJSlevel[index]}',
//                          'Успеваемость ${dataJSlevel[1]}',
                        style: new TextStyle(
                            fontSize: 19.5,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          print(position);

                            return ViewStudent(position);

                        },
                      ),
                    );

                    // debugPrint('$position');
                    // debugPrint('OK');
                  },
                ),
              );
            }),

        floatingActionButton: FloatingActionButton(
          onPressed: () => createDemoBase(),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),

        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.update), title: Text('Обнавить')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), title: Text('Создать')),
            ],
            onTap: (int i) {
              if (i == 0) {
                listStatus = true;
                listData();
                if (CreatStudentState(1).status == true) listStatus = true;
              }
              if (i == 1) {
                print('OOOOKKKKKKKK');
                dataUserVariable().datUsrVar(numBaseData);
                print('!!!!!!================!!!!!!');
                createStudent();
                if (CreatStudentState(1).status == true) listStatus = true;
              }
            }),
      ),
    );
  }
}

initData() {
  database.reference().child('Количество').once().then((DataSnapshot snapshot) {
    dataUserVariable().numberStudent = snapshot.value["coll"];
    dataUserVariable().id = snapshot.value["coll"];

    //sleep(const Duration(seconds: 3));
  });
}

void saveBaseNum() {
  database.reference().child('Количество').set({
    'coll': 0,
  });
}

// Future<void> listData() async {

void readBase() {
  database
      .reference()
      .child('Ученик 1')
      .once()
      .then((DataSnapshot snapshot) {});
}

void deleteBase() {
  database.reference().child('Ученик 0').remove();
}

void createDemoBase() {
  var num = 5;

  database.reference().child('Количество').set({
    'coll': num + 1,
  });

  for (var x = 0; x < num + 1; x++) {
    database.reference().child('Ученик $x').set({
      '1 Пол': '  Мужской',
      '2 Имя': '  Валентин',
      '3 Фамилия': '  Валериевич',
      '4 Возраст': '  18',
      '5 Успеваемость': '   12'
    });
  }
}

class Update extends StatefulWidget {
  int id;
  Update(this.id);

  @override
  Widget build(BuildContext context) {
    return ViewStudent(id);
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  }
}

class UpdateDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Пожалуйста сначало обновите список!'),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text('Ok'),
        ),
      ],
    );
  }
}
