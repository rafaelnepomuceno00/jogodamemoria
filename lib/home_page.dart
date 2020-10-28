import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodamemoria/animal.dart';
import 'package:jogodamemoria/colors.dart';
import 'package:jogodamemoria/numbers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text(
            'Jogo da Memória',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                      color: Colors.black54,
                      blurRadius: 2,
                      offset: Offset(1, 2))
                ]),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
          color: Colors.lightBlueAccent,
          child: Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return FlatButton(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: _list[index].primaryClr,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 4,
                                        color: Colors.black26,
                                        spreadRadius: 0.3,
                                        offset: Offset(3, 4))
                                  ]),
                            ),
                            Container(
                                height: 90,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: _list[index].secundaryClr,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 4,
                                          color: Colors.black12,
                                          spreadRadius: 0.3,
                                          offset: Offset(5, 3))
                                    ]),
                                child: Center(
                                  child: Text(
                                    _list[index].name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black26,
                                            blurRadius: 2,
                                            offset: Offset(1, 2),
                                          ),
                                          Shadow(
                                              color: _list[index].primaryClr,
                                              blurRadius: 2,
                                              offset: Offset(0.5, 2))
                                        ]),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                _list[index].goTo));
                      });
                }),
          ),
        ));
  }
}

class Details {
  String name;
  Color primaryClr;
  Color secundaryClr;
  Widget goTo;

  Details({this.name, this.primaryClr, this.secundaryClr, this.goTo});
}

List<Details> _list = [
  Details(
      name: 'Cores',
      primaryClr: Colors.green,
      secundaryClr: Colors.green[400],
      goTo: ColorsPage()),
  Details(
      name: 'Números',
      primaryClr: Colors.red,
      secundaryClr: Colors.red[400],
      goTo: NumbersPage()),
  Details(
      name: 'Animais',
      primaryClr: Colors.indigo,
      secundaryClr: Colors.indigo[400],
      goTo: AnimalsGame()),
];
