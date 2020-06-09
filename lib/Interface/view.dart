import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:student/Interface/list.dart';
import './EditStudentData.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
final scaffoldKey = GlobalKey<ScaffoldState>();

var dataJSpol, dataJSname, dataJSlastName, dataJSage, dataJSlevel;

class ViewStudent extends StatefulWidget {
  int id;
  ViewStudent(this.id);

  @override
  _ViewStudent createState() => _ViewStudent(id);
}

class _ViewStudent extends State<ViewStudent> {
  int id;
  _ViewStudent(this.id);

  bool clears = false;

  bool dell = false;

  void editStudent() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return EditStudent(id, dataJSpol, dataJSname, dataJSlastName,
              dataJSage, dataJSlevel);
        },
      ),
    );
  }

  void readBase() {
    database.reference().child('Ученик $id').once().then((DataSnapshot snapshot) {
      setState(() {
        dataJSpol = snapshot.value["1 Пол"];
        dataJSname = snapshot.value["2 Имя"];
        dataJSlastName = snapshot.value["3 Фамилия"];
        dataJSage = snapshot.value["4 Возраст"];
        dataJSlevel = snapshot.value["5 Успеваемость"];
      });
    });
  }

  void deleteBase() {

    database.reference().child('Ученик $id').once().then((DataSnapshot snapshot) {
      
        dataJSpol = snapshot.value["1 Пол"];
        if (dataJSpol == null) print('>>>>>>>>>>>>>>>>>>>>>>');
        else print('dadadadaTaDAA ========= $dataJSpol');
    });


    dell = true;

    int red;
    database.reference().child('Ученик $id').remove();

    database
        .reference()
        .child('Количество')
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        red = snapshot.value["coll"];
      });

      print('red = $red');

      if (red > 1) {
        red--;
        database.reference().child('Количество').set({'coll': red});
        red++;
      } else
        database.reference().child('Количество').set({'coll': 0});
    });
    readBase();

    setState(() {
      clears = true;
      //////////////////////////////////////////////////////////////////////////////////////////////////
    });
  }

  @override
  Widget build(BuildContext context) {
    readBase();
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    //if (clears == false)
    return SafeArea(
      key: _scaffoldKey,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Center(child: Text('View Student')),
        //   backgroundColor: Colors.blueAccent,
        // ),
        backgroundColor: Colors.white,
        body: Card(
          color: Colors.white70,
          child: Center(
            child: Container(
              height: 300.0,
              child: ListTile(
                title: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        '   $id   ',
                        style: new TextStyle(
                            fontSize: 50.0,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500),
                      ),
                      new Text(
                        'Пол          $dataJSpol',
//                          'Пол          ${dataJSpol[1]}',
                        style: new TextStyle(
                            fontSize: 19.5,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500),
                      ),
                      new Text(
                        'Имя          $dataJSname',
//                          'Имя          ${dataJSname[1]}',
                        style: new TextStyle(
                            fontSize: 19.5,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500),
                      ),
                      new Text(
                        'Фамилия     $dataJSlastName',
//                          'Фамилия     ${dataJSlastName[1]}',
                        style: new TextStyle(
                            fontSize: 19.5,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500),
                      ),
                      new Text(
                        'Возраст      $dataJSage',
//                          'Возраст      ${dataJSage[1]}',
                        style: new TextStyle(
                            fontSize: 19.5,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500),
                      ),
                      new Text(
                        'Успеваемость $dataJSlevel',
//                          'Успеваемость ${dataJSlevel[1]}',
                        style: new TextStyle(
                            fontSize: 19.5,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.edit), title: Text('Изменить')),
            BottomNavigationBarItem(
                icon: Icon(Icons.delete), title: Text('Удалить')),
          ],
          onTap: (int i) {
            if (i == 0) {
              if (dell == false) {
                editStudent();
              } else {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) =>
                            DelReall()));
              }
            }

            if (i == 1) {
              if (dell == false) {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) => Del()));
                deleteBase();
              } else {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) =>
                            DelReall()));
              }
            }
          },
        ),
      ),
    );
  }
}

class Del extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Студент удален'),
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

class DelReall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Студент уже удален!'),
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
