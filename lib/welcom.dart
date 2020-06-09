import 'package:flutter/material.dart';
import './Interface/list.dart';

class Welcom extends StatefulWidget {
  Welcom({Key key, this.title}) : super(key: key);

  final String title;

  var X;

  @override
  _Welcom createState() => _Welcom();
}

class _Welcom extends State<Welcom> {
  final TextEditingController _userConttroller = new TextEditingController();
  final TextEditingController _passConttroller = new TextEditingController();
  String _welcomString = '';

  bool welcomStatus = false;

  void startBase() {
    var user;
    var pass;

    if (_userConttroller.text.isNotEmpty && _passConttroller.text.isNotEmpty) {
      user = _userConttroller.text;
      pass = _passConttroller.text;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          //readBase();

          
        if (user == 'admin' && pass == 'admin') return ListData();


          return SafeArea(
            child: Scaffold(
              // appBar: AppBar(
              //   title: Text(widget.title),
              // ),
              body: Center(
                child: Center(
                  child: Container(
                    padding: EdgeInsetsDirectional.fromSTEB(50, 50, 50, 50),
                    child: Center(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Неправильный',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.redAccent,
                              ),
                            ),
                            Text(
                              'логин или Пароль!',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.redAccent,
                              ),
                            ),
                            Text(
                              'Повторите попытку',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.redAccent,
                              ),
                            ),
                            Text(''),
                            Text(
                              'Логин = admin',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'Пароль = admin',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _erase() {
    setState(() {
      _userConttroller.clear();
      _passConttroller.clear();
    });
  }

  void _welcom() {
    setState(() {
      if (_userConttroller.text.isNotEmpty &&
          _passConttroller.text.isNotEmpty) {
        _welcomString = _userConttroller.text;
      } else
        _welcomString = 'Nothing!';
    });
  }

  @override
  Widget build(BuildContext context) {
    //saveBase();
    //readBase();

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Center(
              child: Container(
                padding: EdgeInsetsDirectional.fromSTEB(50, 180, 50, 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/fire.png'),
                    //SizedBox(height: 100.0),
                    TextField(
                      controller: _userConttroller,
                      decoration: InputDecoration(
                        hintText: ' Логин',
                        icon: Icon(Icons.person),
                      ),
                    ),
                    TextField(
                      controller: _passConttroller,
                      decoration: InputDecoration(
                        hintText: ' Пароль',
                        icon: Icon(Icons.vpn_key),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20.0),
                    FlatButton(
                        child: Text(
                          'Начать',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                          //backgroundColor: Colors.green,
                        ),
                        color: Colors.green[50],
                        onPressed: () {
                          startBase();
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
