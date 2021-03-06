import 'package:car_rental/searchscreen.dart';

import 'car_widget.dart';
import 'package:provider/provider.dart';
import './AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import './AppDrawer.dart';
import 'data.dart';
import 'book_car.dart';
import 'dart:math';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

int toggle = 0;

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController _con;
  TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 375),
    );
  }

  final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();
  String input = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Search for a car",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Color(0xffF2F3F7),
        child: Center(
          child: Container(
            height: 100.0,
            width: 250.0,
            alignment: Alignment(-1.0, 0.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 375),
              height: 48.0,
              width: (toggle == 0) ? 48.0 : 250.0,
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: -10.0,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 375),
                    top: 6.0,
                    right: 7.0,
                    curve: Curves.easeOut,
                    child: AnimatedOpacity(
                      opacity: (toggle == 0) ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 200),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xffF2F3F7),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: AnimatedBuilder(
                          child: GestureDetector(
                              child: Icon(
                                Icons.search,
                                size: 20.0,
                              ),
                              onTap: () {
                                _formKey.currentState.save();
                                Map<String, String> data = {"key": input};
                                Provider.of<AppProvider>(context, listen: false)
                                    .search(data);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Searchcar()),
                                );
                              }),
                          builder: (context, widget) {
                            return Transform.rotate(
                              angle: _con.value * 2.0 * pi,
                              child: widget,
                            );
                          },
                          animation: _con,
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 375),
                    left: (toggle == 0) ? 20.0 : 40.0,
                    curve: Curves.easeOut,
                    top: 11.0,
                    child: AnimatedOpacity(
                      opacity: (toggle == 0) ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 200),
                      child: Container(
                        height: 23.0,
                        width: 180.0,
                        child: TextFormField(
                          key: _formKey,
                          onSaved: (value) {
                            input = value;
                          },
                          controller: _textEditingController,
                          cursorRadius: Radius.circular(10.0),
                          cursorWidth: 2.0,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: 'Search...',
                            labelStyle: TextStyle(
                              color: Color(0xff5B5B5B),
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                            ),
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    child: IconButton(
                      splashRadius: 19.0,
                      icon: Image.network(
                        'https://www.flaticon.com/svg/static/icons/svg/709/709592.svg',
                        height: 18.0,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            if (toggle == 0) {
                              toggle = 1;
                              _con.forward();
                            } else {
                              toggle = 0;
                              _textEditingController.clear();
                              _con.reverse();
                            }
                          },
                        );
                      },
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
}
